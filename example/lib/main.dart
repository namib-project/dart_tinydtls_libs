import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:dart_tinydtls/dart_tinydtls.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:dart_tinydtls_libs/dart_tinydtls_libs.dart';

final random = Random();

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  int _responseCounter = 0;

  String? _response = "No Response";

  bool _sending = false;

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion =
          await DartTinydtlsLibs.platformVersion ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  // FIXME(JKRhb): After multiple exchanges tinyDTLS encounters some errors.
  //               This example should therefore only be seen as a proof of
  //               concept for now, but fixed in later versions.
  void _sendRequest() async {
    setState(() {
      _sending = true;
    });

    const address = "::1";
    final port = random.nextInt(1 << 16);

    final server = await DtlsServer.bind(InternetAddress.anyIPv6, port,
        keyStore: {"Client_identity": "secretPSK"});
    server.listen((connection) {
      connection.listen((event) {
        setState(() {
          _responseCounter++;
        });
        final response =
            "${utf8.decode(event.data)} Response $_responseCounter";
        connection.send(utf8.encode(response));
      });
    });
    final client = await DtlsClient.bind(InternetAddress.anyIPv6, 0);

    final pskCredentials = PskCredentials("Client_identity", "secretPSK");

    final connection = await client.connect(InternetAddress(address), port,
        pskCredentials: pskCredentials, eventListener: (event) {
      if (event == DtlsEvent.dtlsEventCloseNotify) {
        client.close();
      }
    });
    connection
      ..listen((event) {
        server.close();
        setState(() {
          _response = utf8.decode(event.data);
        });
      })
      ..send(utf8.encode('Hello World'));
    _sending = false;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'
              'Request counter: $_responseCounter\n'
              'Response: $_response'),
        ),
        floatingActionButton: IconButton(
            onPressed: !_sending ? _sendRequest : null,
            icon: const Icon(Icons.send)),
      ),
    );
  }
}

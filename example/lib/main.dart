// Copyright 2022 The NAMIB Project Developers. All rights reserved.
// See the README as well as the LICENSE file for more information.
//
// SPDX-License-Identifier: EPL-1.0 OR BSD-3-CLAUSE

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:dart_tinydtls/dart_tinydtls.dart';
import 'package:flutter/material.dart';

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
  int _responseCounter = 0;

  String? _response = "No Response";

  bool _sending = false;

  // FIXME(JKRhb): After multiple exchanges tinyDTLS encounters some errors.
  //               This example should therefore only be seen as a proof of
  //               concept for now, but fixed in later versions.
  void _sendRequest() async {
    setState(() {
      _sending = true;
    });

    const address = "::1";
    final port = random.nextInt(1 << 16);

    final identity = Uint8List.fromList("Client_identity".codeUnits);
    final preSharedKey = Uint8List.fromList("secretPSK".codeUnits);

    final server = await DtlsServer.bind(InternetAddress.anyIPv6, port,
        pskKeyStoreCallback: ((identity) => preSharedKey));
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

    final pskCredentials =
        PskCredentials(identity: identity, preSharedKey: preSharedKey);

    final connection = await client.connect(InternetAddress(address), port,
        pskCallback: (identity) => pskCredentials,
        eventListener: (event) {
          if (event.requiresClosing) {
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
          child: Text('Request counter: $_responseCounter\n'
              'Response: $_response'),
        ),
        floatingActionButton: IconButton(
            onPressed: !_sending ? _sendRequest : null,
            icon: const Icon(Icons.send)),
      ),
    );
  }
}

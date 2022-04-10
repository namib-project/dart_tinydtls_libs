import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dart_tinydtls_libs/dart_tinydtls_libs.dart';

void main() {
  const MethodChannel channel = MethodChannel('dart_tinydtls_libs');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DartTinydtlsLibs.platformVersion, '42');
  });
}

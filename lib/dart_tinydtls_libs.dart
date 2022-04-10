
import 'dart:async';

import 'package:flutter/services.dart';

class DartTinydtlsLibs {
  static const MethodChannel _channel = MethodChannel('dart_tinydtls_libs');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

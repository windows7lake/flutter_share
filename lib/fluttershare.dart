import 'dart:async';

import 'package:flutter/services.dart';

class Fluttershare {
  static const MethodChannel _channel =
      const MethodChannel('fluttershare');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}

import 'dart:async';

import 'package:flutter/services.dart';

class FlutterShare {
  static const MethodChannel _channel = const MethodChannel('fluttershare');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<void> share(ShareModel shareModel) async {
    await _channel.invokeMethod("share", {
      "platform": shareModel.platform.toString(),
      "text": shareModel.text,
      "image": shareModel.image,
    });
  }
}

class ShareModel {
  SharePlatform platform;
  String text;
  String image;

  ShareModel({
    this.platform,
    this.text,
    this.image,
  });
}

enum SharePlatform { Line, Facebook }

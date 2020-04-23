import 'dart:async';

import 'package:flutter/services.dart';

class FlutterShare {
  static const MethodChannel _channel = const MethodChannel('fluttershare');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    print(version);
    return version;
  }

  /// response: { "state": 0, "msg": "success" }
  /// state: 0. success   1. fail   2. cancel
  static Future<dynamic> share(
      ShareModel shareModel, {
        Function(int, String) result,
      }) {
    Future<dynamic> callback = _channel.invokeMethod("share", {
      "platform": shareModel.platform.toString(),
      "text": shareModel.text ?? "",
      "image": shareModel.image ?? "",
    });
    callback.then((dynamic response) {
      if (result != null) {
        result(response["state"], response["msg"]);
      }
    });
    return callback;
  }
}

class ShareModel {
  SharePlatform platform;
  String text;
  String image;

  ShareModel({
    this.platform,
    this.text = "",
    this.image = "",
  });
}

enum SharePlatform { Line, Facebook }

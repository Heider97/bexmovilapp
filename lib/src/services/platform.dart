import 'package:flutter/services.dart';

class PlatformService {
  static PlatformService? _instance;

  static Future<PlatformService?> getInstance() async {
    _instance ??= PlatformService();
    return _instance;
  }

  static const methodChannelName = 'io.bexmovil.utils';
  static const  methodChannel = MethodChannel(methodChannelName);

  static Future<void> preventScreenCapture({bool enable = false}) {
    return methodChannel.invokeMethod<void>('preventScreenCapture', {
      'enable': enable,
    });
  }
}
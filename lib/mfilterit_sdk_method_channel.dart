import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'mfilterit_sdk_platform_interface.dart';

/// An implementation of [MfilteritSdkPlatform] that uses method channels.
class MethodChannelMfilteritSdk extends MfilteritSdkPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('mfilterit_sdk');

  @override
  Future<String?> debugMode(bool name) async {
    final response = await methodChannel.invokeMethod<String>('debugMode', {'name':name});
    return response;
  }

  @override
  Future<String?> applicationData(String data) async {
    final response = await methodChannel.invokeMethod<String>('applicationData', {
      'data' : data
    });
    return response;
  }

  @override
  Future<String?> initSDK(String vendorId, int datapointsLevel) async {
    final transactionId = await methodChannel.invokeMethod<String>('initSDK', {
      'vendorId' : vendorId,
      'datapointsLevel' : datapointsLevel
    });
    return transactionId;
  }

  @override
  Future<String?> sendEvent(String vendorId, String payload, String eventType) async {
    final transactionId = await methodChannel.invokeMethod<String>('sendEvent', {
      'vendorId' : vendorId,
      'payload' : payload,
      'eventType' : eventType
    });
    return transactionId;
  }
}

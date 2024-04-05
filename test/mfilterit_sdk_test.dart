import 'package:flutter_test/flutter_test.dart';
import 'package:mfilterit_sdk/mfilterit_sdk.dart';
import 'package:mfilterit_sdk/mfilterit_sdk_platform_interface.dart';
import 'package:mfilterit_sdk/mfilterit_sdk_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockMfilteritSdkPlatform
    with MockPlatformInterfaceMixin
    implements MfilteritSdkPlatform {

  @override
  Future<String?> applicationData(String data) {
    // TODO: implement applicationData
    throw UnimplementedError();
  }

  @override
  Future<String?> debugMode(bool name) {
    // TODO: implement debugMode
    throw UnimplementedError();
  }

  @override
  Future<String?> initSDK(String vendorId, int datapointsLevel) {
    // TODO: implement initSDK
    throw UnimplementedError();
  }

  @override
  Future<String?> sendEvent(String vendorId, String payload, String eventType) {
    // TODO: implement sendEvent
    throw UnimplementedError();
  }
}

void main() {
  final MfilteritSdkPlatform initialPlatform = MfilteritSdkPlatform.instance;

  test('$MethodChannelMfilteritSdk is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelMfilteritSdk>());
  });

  test('getPlatformVersion', () async {
    MfilteritSdk mfilteritSdkPlugin = MfilteritSdk();
    MockMfilteritSdkPlatform fakePlatform = MockMfilteritSdkPlatform();
    MfilteritSdkPlatform.instance = fakePlatform;
    String vendorId = "sdk_test_v2";
    const dataPointsLevel3 = 3;
    final String? transactionId = await mfilteritSdkPlugin.initSDK(vendorId, dataPointsLevel3);
    expect(transactionId?.isNotEmpty, true);
  });
}

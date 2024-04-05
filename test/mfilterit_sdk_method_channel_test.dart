import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mfilterit_sdk/mfilterit_sdk_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  MethodChannelMfilteritSdk platform = MethodChannelMfilteritSdk();
  const MethodChannel channel = MethodChannel('mfilterit_sdk');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(
      channel,
      (MethodCall methodCall) async {
        return '42';
      },
    );
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger.setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    String vendorId = "sdk_test_v2";
    const dataPointsLevel3 = 3;
    final String? transactionId = await platform.initSDK(vendorId, dataPointsLevel3);
    expect(transactionId?.isNotEmpty, true);
  });
}

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'mfilterit_sdk_method_channel.dart';

abstract class MfilteritSdkPlatform extends PlatformInterface {
  /// Constructs a MfilteritSdkPlatform.
  MfilteritSdkPlatform() : super(token: _token);

  static final Object _token = Object();

  static MfilteritSdkPlatform _instance = MethodChannelMfilteritSdk();

  /// The default instance of [MfilteritSdkPlatform] to use.
  ///
  /// Defaults to [MethodChannelMfilteritSdk].
  static MfilteritSdkPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [MfilteritSdkPlatform] when
  /// they register themselves.
  static set instance(MfilteritSdkPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> debugMode(bool name) {
    throw UnimplementedError('debugmode() has not been implemented');
  }

  Future<String?> applicationData(String data) {
    throw UnimplementedError('applicationData() has not been implemented');
  }

  Future<String?> initSDK(String vendorId, int datapointsLevel) {
    throw UnimplementedError('initSDK() has not been implemented');
  }

  Future<String?> sendEvent(String vendorId, String payload, String eventType) {
    throw UnimplementedError('initSDK() has not been implemented');
  }
}

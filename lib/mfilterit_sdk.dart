
import 'mfilterit_sdk_platform_interface.dart';

//Dart Interface to SDK
class MfilteritSdk {
  //set SDK debug mode, returns nothing.
  Future<void> debugMode(bool name) {
    return MfilteritSdkPlatform.instance.debugMode(name);
  }

  //set applicationData, returns nothing.
  Future<void> applicationData(String data) {
    return MfilteritSdkPlatform.instance.applicationData(data);
  }

  //Initialises SDK, returns a string which is a transactionID for reference.
  Future<String?> initSDK(String vendorId, int datapointsLevel) {
    return MfilteritSdkPlatform.instance.initSDK(vendorId, datapointsLevel);
  }

  //sendEvent for events such as referrals etc, returns a string which can take value "success" or "failure"
  Future<String?> sendEvent(String vendorId, String payload, String eventType) {
    return MfilteritSdkPlatform.instance.sendEvent(vendorId, payload, eventType);
  }
}

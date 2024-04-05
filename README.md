![](https://www.mfilterit.com/wp-content/uploads/2023/11/Final-Logo-png.png)
# mFilterit Flutter Plugin
The Flutter plugin for mFilterIt Android Java SDK.

This flutter plugin encapsulates the mFilterIt AppFraud 7.0.0 Android Java SDK.
#
### Requirements

1. Use Android Marshmallow 6.0 (API level 23) and above.
2. Dependencies (add if **required/not picked** when importing plugin from pub.dev)
	
```sh
	implementation 'com.android.installreferrer:installreferrer:1.0'
	implementation 'com.android.support:multidex:1.0.0'
	implementation 'com.google.android.gms:play-services-base:18.0.1'
	implementation 'com.google.android.gms:play-services-ads-identifier:18.0.0'
	implementation 'com.google.android.gms:play-services-location:19.0.1'
```
#
### Permissions

1. Mandatory Permissions:
	```sh
	<uses-permission android:name="android.permission.INTERNET" />
	<uses-permission android:name="android.permission.ACCESS_NETWORK_STATE" />

	```
2. Optional Permissions:
	```sh
	<uses-permission android:name="android.permission.READ_PHONE_STATE" />
	<uses-permission android:name="android.permission.WRITE_EXTERNAL_STORAGE" />
	<uses-permission android:name="android.permission.ACCESS_WIFI_STATE" />
	<uses-permission android:name="android.permission.GET_ACCOUNTS" />
	<uses-permission android:name="android.permission.READ_CALL_LOG" />
	<uses-permission android:name="android.permission.READ_SMS" />
	<uses-permission android:name="android.permission.READ_CONTACTS" />
	```
	The mFilterIt algorithm works most **efficiently** when all permissions are allowed. However, the SDK is
	able detect some fraudulent activity with the mandatory permissions itself.
#
### Usage

Example implementation [here](https://pub.dev/packages/mfilterit_sdk/example), further explanation below.

1. **Create an instance of MfilteritSDK.**
	```sh
	final _mFilterItSdkPlugin = MfilteritSdk();
	```
2. **Set SDK debug mode to false for production.**
	```sh
	_mFilterItSdkPlugin.debugMode(false);
	```
3. **Set custom application data.**

	Typically the Referral String received from Google PlayStore is passed to this method.\
	Alternatively, you can pass your own unique identifier for this installation, which can be later used to correlate your install data with that reported by the SDK.
	```sh
	_mFilterItSdkPlugin.applicationData("custom Flutter application data!");
	```
4. **Initialize the SDK.**\
	The SDK is initialized by invoking the initSDK(String vendorId, int dataPointsLevel) plugin method in async as it is a platform invocation with String return.\
	This is a unique Vendor ID string allocated to the app developer.The Vendor ID is provided to you at registration, and is critical to identify the server side endpoint.\
	Please contact us for the VendorID at contact@mﬁlterit.com.\
	Set dataPointsLevel to Integer "1".\
	You will receive a transactionId which is for reference.
	```sh
	transactionId = await _mFilterItSdkPlugin.initSDK(vendorId, dataPointLevel3);
	```
5. **Send an event to SDK.**

	Invoke the sendEvent(String vendorId, String payload,String "ReferralEvent") plugin method in async as it is a platform invocation with String return.\
	You will receive a response which can take string value "success" or "failure"
	```sh
	response = await _mFilterItSdkPlugin.sendEvent(vendorId, payload, referralEvent);
	```
6. **Summary Code Snippet:**
	```sh
	  Future<void> initMfilteritSDK() async {
	    print('initMFSDK called!');
	    String _transactionId = 'Unknown';
	    String responseSendEvent = 'Unknown';
	    final _mFilterItSdkPlugin = MfilteritSdk();

	    const dataPointLevel0 = 0;
	    const dataPointLevel1 = 1;
	    const dataPointLevel3 = 3;
	    const referralEvent = "ReferralEvent";
	    const uninstallEvent = "UninstallEvent";
	    const newUserEvent = "NewUserEvent";
	    String vendorId = "mf_flutter_sdk_plugin_test";
	    String? transactionId = 'empty';
	    String? response = 'empty';
	    String? payload = "{\"user_id\":\"69694200-f47f-4731-bf52-eb5008f0660a\",\"referrer\":\"0bfeec99-3846-4ddf-9276-2c7396518651\",\"phone_number\":\"mobile_number\",\"country_code\":\"+91\",\"email\":\"\",\"device_type\":\"ANDROID_TEST_FLUTTER\",\"unique_device_id\":\"ca0c291ebe6d6935\",\"os_version\":\"12\",\"app_version\":\"6.9\",\"appName\":\"com.clientapp\",\"utm_source\":\"\",\"referral_status\":\"referral\",\"referral_code\":\"\",\"referral_code_mode\":\"Link\",\"event_log_time\":\"2024-03-22T16:59:36+05:30\",\"event_name\":\"ReferralEvent\"}";
	    // Platform messages may fail, so we use a try/catch PlatformException.
	    // We also handle the message potentially returning null.
	    try {
	      //Set SDK debug mode to false for production
	      _mFilterItSdkPlugin.debugMode(false);
	      //Set SDK Application Data
	      _mFilterItSdkPlugin.applicationData("custom Flutter application data!");
	      //Trigger SDK INIT
	      transactionId = await _mFilterItSdkPlugin.initSDK(vendorId, dataPointLevel3);
	      //sendEvent() to SDK
	      response = await _mFilterItSdkPlugin.sendEvent(vendorId, payload, referralEvent);
	    } on PlatformException {
	      print('Exception of platform!');
	    }

	    _transactionId = transactionId!;
	    responseSendEvent = response!;
	    print('transacationId:$_transactionId, responseSendEvent:$responseSendEvent');
	  }
	```
#
This project is a Flutter
[plug-in package](https://flutter.dev/developing-packages/),
a specialized package that includes platform-specific implementation code for
Android **ONLY!**

For help getting started with Flutter development, view the
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.


import 'dart:isolate';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:mfilterit_sdk/mfilterit_sdk.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _transactionId = 'Unknown';
  String responseSendEvent = 'Unknown';
  final _mFilterItSdkPlugin = MfilteritSdk();

  static const dataPointLevel0 = 0;
  static const dataPointLevel1 = 1;
  static const dataPointLevel3 = 3;
  static const referralEvent = "ReferralEvent";
  static const uninstallEvent = "UninstallEvent";
  static const newUserEvent = "NewUserEvent";

  @override
  void initState() {
    super.initState();
    initMfilteritSDK();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initMfilteritSDK() async {
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

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _transactionId = transactionId!;
      responseSendEvent = response!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('mFilterIt Flutter Plugin Test'),
        ),
        body: Center(
          child: Text('transactionId: $_transactionId,\nsendEventResponse:$responseSendEvent'),
        ),
      ),
    );
  }
}

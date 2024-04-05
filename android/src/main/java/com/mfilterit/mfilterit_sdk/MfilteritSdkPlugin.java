package com.mfilterit.mfilterit_sdk;

import android.content.Context;
import androidx.annotation.NonNull;

import com.mfilterit.MFilterIt;
import com.mfilterit.MFilterItCallbackListener;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/** MfilteritSdkPlugin */
public class MfilteritSdkPlugin implements FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private MethodChannel channel;
  private Context context;

  @Override
  public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
    channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), "mfilterit_sdk");
    context = flutterPluginBinding.getApplicationContext();
    channel.setMethodCallHandler(this);
  }

  @Override
  public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
    String vendorId;
    switch(call.method){
      case "debugMode":
        boolean debugMode = call.argument("name");
        MFilterIt.setDebugMode(debugMode);
        result.success("ok borgir");
        break;
      case "applicationData":
        String data = call.argument("data");
        MFilterIt.setApplicationData(context, data);
        result.success("ok applicationData set borgir");
        break;
      case "initSDK":
        vendorId = call.argument("vendorId");
        int datapointsLevel = call.argument("datapointsLevel");
        String transactionId = MFilterIt.sdkInit(context, vendorId, datapointsLevel);
        result.success(transactionId);
        break;
      case "sendEvent":
        vendorId = call.argument("vendorId");
        String payload = call.argument("payload");
        String eventType = call.argument("eventType");
        MFilterIt.sendEvent(context, vendorId, payload, eventType, new MFilterItCallbackListener() {
          @Override
          public void onMFilterItResponse(String s) {
            result.success(s);
          }
        });
        break;
      default:
        result.notImplemented();
    }
  }

  @Override
  public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
    channel.setMethodCallHandler(null);
  }
}

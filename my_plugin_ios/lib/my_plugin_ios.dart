import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// The iOS implementation of [MyPluginPlatform].
class MyPluginIOS extends MyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin');

  /// Registers this class as the default instance of [MyPluginPlatform]
  static void registerWith() {
    MyPluginPlatform.instance = MyPluginIOS();
  }

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Stream<Map<String, double>> listenChangesGPS()  {
    StreamController<Map<String, double>> streamController = StreamController();
    Map<String, double> coordenadas = {
      "lat":0.01,
      "lon":0.01
    };

    methodChannel.setMethodCallHandler((MethodCall call) {
      switch (call.method) {
        case "onLocation":
          print('datos desde nativo a iOS');
          print(call.arguments['lat']);
          print(call.arguments['lng']);
          Map<String, double> coordenadas = {
            'lat': call.arguments['lat'],
            'lon': call.arguments['lng'],
          };
          streamController.add(coordenadas);
          break;
        default:
          return Future.value(null);
      }
      return Future.value(null);
    });


    return streamController.stream;
  }

  @override
  Future<void> startLocation() async {
    await methodChannel.invokeMethod("startLocation");
  }

  @override
  Future<void> stopLocation() async {
    await methodChannel.invokeMethod("stopLocation");
  }
}

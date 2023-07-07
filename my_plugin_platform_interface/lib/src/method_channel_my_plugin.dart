import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/services.dart';
import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

/// An implementation of [MyPluginPlatform] that uses method channels.
class MethodChannelMyPlugin extends MyPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('my_plugin');
  final _eventChannel = const EventChannel('geolocation.listener');
  late StreamSubscription _subscription;

  @override
  Future<String?> getPlatformName() {
    return methodChannel.invokeMethod<String>('getPlatformName');
  }

  @override
  Future<void> startLocation() async {
    await methodChannel.invokeMethod("startLocation");
  }

  @override
  Future<void> stopLocation() async {
    await methodChannel.invokeMethod("stopLocation");
    _subscription.cancel();
  }

  @override
  Stream<Map<String, double>> listenChangesGPS() {
    StreamController<Map<String, double>> streamController =
        StreamController<Map<String, double>>();

    _eventChannel.receiveBroadcastStream().listen((event) {
      streamController.add(event.cast<String, double>());
    });

    return streamController.stream;
  }
}

import 'dart:async';

import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

MyPluginPlatform get _platform => MyPluginPlatform.instance;

/// Returns the name of the current platform.
Future<String> getPlatformName() async {
  final platformName = await _platform.getPlatformName();
  if (platformName == null) throw Exception('Unable to get platform name.');
  return platformName;
}


Future<void> startLocation() async {
  await _platform.startLocation();
}


Future<void> stopLocation() async {
  await _platform.stopLocation();
}


Stream<Map<String, double>> listenChangesGPS() {
  StreamController<Map<String, double>> streamController = StreamController<Map<String, double>>();

  _platform.listenChangesGPS().listen((event) {
    streamController.add(event.cast<String, double>());
  });

  return streamController.stream;
}



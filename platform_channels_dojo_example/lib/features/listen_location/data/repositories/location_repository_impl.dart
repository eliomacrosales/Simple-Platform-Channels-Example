import 'dart:async';

import '../../../../core/permission/permission_handler.dart';
import '../../domain/repositories/location_repository.dart';

import 'package:my_plugin_platform_interface/my_plugin_platform_interface.dart';

MyPluginPlatform get _platform => MyPluginPlatform.instance;

class LocationRepositoryImpl implements LocationRepository {
  final PermissionHandler permissionHandler;
  LocationRepositoryImpl({required this.permissionHandler});

  @override
  Stream<Map<String, double>> listenChanges() {
    StreamController<Map<String, double>> streamController =
    StreamController<Map<String, double>>();
    _platform.listenChangesGPS().listen((event) {
      streamController.add(event.cast<String, double>());
    });

    return streamController.stream;
  }

  @override
  Future<void> startLocationGPS() async {
    await _platform.startLocation();
  }

  @override
  Future<void> stopLocationGPS() async {
    await _platform.stopLocation();
  }
}

import 'dart:async';
import 'package:gps_plugin/my_plugin.dart';

import '../../../../core/permission/permission_handler.dart';
import '../../domain/repositories/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final PermissionHandler permissionHandler;
  LocationRepositoryImpl({required this.permissionHandler});

  @override
  Stream<Map<String, double>> listenChanges() {
    StreamController<Map<String, double>> streamController =
    StreamController<Map<String, double>>();
    listenChangesGPS().listen((event) {
      streamController.add(event.cast<String, double>());
    });

    return streamController.stream;
  }

  @override
  Future<void> startLocationGPS() async {
    await startLocation();
  }

  @override
  Future<void> stopLocationGPS() async {
    await stopLocation();
  }
}

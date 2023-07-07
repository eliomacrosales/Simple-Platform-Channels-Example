import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

import '../../../../core/permission/permission_handler.dart';
import '../../domain/usecases/listen_changes_GPS.dart';
import '../../domain/usecases/start_location.dart';
import '../../domain/usecases/stop_location.dart';

class HomeProvider with ChangeNotifier {
  final StartLocationUseCase startLocationUseCase;
  final StopLocationUseCase stopLocationUseCase;
  final ListenChangesGPSUseCase listenChangesGPSUseCase;
  final PermissionHandler permissionHandler;

  double _latitude = 0.0;
  double get latitude => _latitude;

  double? _longitude = 0.0;
  double? get longitude => _longitude;

  bool _listeningLocation = false;
  bool get listeningLocation => _listeningLocation;

  bool _isPermissionGranted = false;
  bool get isPermissionGranted => _isPermissionGranted;

  HomeProvider(
      {required this.startLocationUseCase,
      required this.stopLocationUseCase,
      required this.listenChangesGPSUseCase,
      required this.permissionHandler});

  Future<void> startLocation() async {
    _listeningLocation = true;
    notifyListeners();
    return await startLocationUseCase.startLocation();
  }

  Future<void> stoptLocation() async {
    _listeningLocation = false;
    notifyListeners();
    return await stopLocationUseCase.stopLocation();
  }

  Future<void> listenChangesGPS() async {
    Stream<Map<String, double>> myStream =
        listenChangesGPSUseCase.listenChangesGPS();
    myStream.listen((data) {
      _latitude = data["lat"] ?? 0.0;
      _longitude = data["lon"];
      notifyListeners();
    }, onError: (error) {

    }, onDone: () {

    });
  }

  Future<bool> getPermissionLocation() async {
    _isPermissionGranted = await permissionHandler.isPermissionGranted();
    notifyListeners();
    return _isPermissionGranted;
  }
}

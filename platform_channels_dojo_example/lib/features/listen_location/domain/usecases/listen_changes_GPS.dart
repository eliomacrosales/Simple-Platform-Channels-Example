import 'dart:async';

import '../repositories/location_repository.dart';

abstract class ListenChangesGPSUseCase {
  Stream<Map<String, double>> listenChangesGPS();
}

class ListenChangesGPSUseCaseImpl implements ListenChangesGPSUseCase {
  final LocationRepository repository;

  ListenChangesGPSUseCaseImpl({required this.repository});

  @override
  Stream<Map<String, double>> listenChangesGPS() {
    StreamController<Map<String, double>> streamController =
        StreamController<Map<String, double>>();
    repository.listenChanges().listen((event) {
      streamController.add(event.cast<String, double>());
    });

    return streamController.stream;
  }
}

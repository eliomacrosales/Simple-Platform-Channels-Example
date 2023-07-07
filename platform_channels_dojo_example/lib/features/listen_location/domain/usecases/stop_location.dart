import '../repositories/location_repository.dart';

abstract class StopLocationUseCase {
  Future<void> stopLocation();
}

class StopLocationUseCaseImpl implements StopLocationUseCase {
  final LocationRepository repository;

  StopLocationUseCaseImpl({required this.repository});

  @override
  Future<void> stopLocation() async {
    return await repository.stopLocationGPS();
  }
}

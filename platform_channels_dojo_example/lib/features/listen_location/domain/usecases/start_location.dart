import '../repositories/location_repository.dart';

abstract class StartLocationUseCase {
  Future<void> startLocation();
}

class StartLocationUseCaseImpl implements StartLocationUseCase {
  final LocationRepository repository;

  StartLocationUseCaseImpl({required this.repository});

  @override
  Future<void> startLocation() async {
    return await repository.startLocationGPS();
  }
}

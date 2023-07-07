import 'package:get_it/get_it.dart';

import '../../features/listen_location/data/repositories/location_repository_impl.dart';
import '../../features/listen_location/domain/repositories/location_repository.dart';
import '../../features/listen_location/domain/usecases/listen_changes_GPS.dart';
import '../../features/listen_location/domain/usecases/start_location.dart';
import '../../features/listen_location/domain/usecases/stop_location.dart';

import '../permission/permission_handler.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Use cases
  sl.registerLazySingleton<StartLocationUseCase>(
    () => StartLocationUseCaseImpl(repository: sl()),
  );
  sl.registerLazySingleton<StopLocationUseCase>(
    () => StopLocationUseCaseImpl(repository: sl()),
  );
  sl.registerLazySingleton<ListenChangesGPSUseCase>(
    () => ListenChangesGPSUseCaseImpl(repository: sl()),
  );

  //Core
  sl.registerLazySingleton<PermissionHandler>(
    () => PermissionHandlerImpl(),
  );

  // Repository
  sl.registerLazySingleton<LocationRepository>(
    () => LocationRepositoryImpl(
      permissionHandler: sl(),
    ),
  );
}

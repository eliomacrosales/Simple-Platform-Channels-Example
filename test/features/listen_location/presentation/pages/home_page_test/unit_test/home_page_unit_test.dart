import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:platform_channels_dojo_example/core/permission/permission_handler.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/listen_changes_GPS.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/start_location.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/stop_location.dart';
import 'package:platform_channels_dojo_example/features/listen_location/presentation/provider/home_provider.dart';

import '../mocks/test_mocks.mocks.dart';

void main() {
  late HomeProvider homeProvider;
  late HomeProvider homeProvider2;

  late StartLocationUseCase startLocationUseCase;
  late StopLocationUseCase stopLocationUseCase;
  late ListenChangesGPSUseCase listenChangesGPSUseCase;
  late PermissionHandler permissionHandler;

  setUp(
        () {
      startLocationUseCase = MockStartLocationUseCase();
      stopLocationUseCase = MockStopLocationUseCase();
      listenChangesGPSUseCase = MockListenChangesGPSUseCase();
      permissionHandler = MockPermissionHandler();

      homeProvider = HomeProvider(
          startLocationUseCase: startLocationUseCase,
          stopLocationUseCase: stopLocationUseCase,
          permissionHandler: permissionHandler,
          listenChangesGPSUseCase: listenChangesGPSUseCase);

      homeProvider2 = HomeProvider(
          startLocationUseCase: startLocationUseCase,
          stopLocationUseCase: stopLocationUseCase,
          permissionHandler: permissionHandler,
          listenChangesGPSUseCase: listenChangesGPSUseCase);
    },
  );

  /// cuando se levanta la app por primera vez
  test(
    'GIVEN the first execution of the app'
        'WHEN the user has not yet granted the location permission'
        'THEN'
        '[latitude and longitude are 0.0,'
        'location permission has not been granted to the user,'
        'has not started to listen to the GPS location of the device]',
        () {
      // Assert
      expect(homeProvider, equals(homeProvider2));
    },
  );

  /// el usuario NO concede permisos de ubicación
  test(
    'Given that the user Request Location Permission'
        'When the user does not grant the location permission'
        'Then'
        '[You must call the function isPermissionGranted()]',
        () async {
      /// Arrange
      when(
        permissionHandler.isPermissionGranted(),
      ).thenAnswer(
            (_) async => false,
      );

      /// Act
      await homeProvider.getPermissionLocation();

      // Assert
      expect(
        homeProvider.isPermissionGranted,
        false,
      );
    },
  );

  test(
    'When the user grants the location permissions and starts listening to the GPS broadcasts'
        'Then the result of the GPS change is displayed on the screen',
        () async {
      /// Arrange
      expect(
        homeProvider.latitude,
        0.0,
      );
      expect(
        homeProvider.longitude,
        0.0,
      );
      when(
        homeProvider.getPermissionLocation(),
      ).thenAnswer(
            (_) async => true,
      );

      when(listenChangesGPSUseCase.listenChangesGPS())
          .thenAnswer((_) => Stream.fromIterable([
        {"lat": -121.32567, "lon": 37.65933},
      ]));

      /// Act
      await homeProvider.getPermissionLocation();
      await homeProvider.listenChangesGPS();

      /// Assert
      expect(
        homeProvider.isPermissionGranted,
        true,
      );
      expect(
        homeProvider.latitude,
        -121.32567,
      );
      expect(
        homeProvider.longitude,
        37.65933,
      );
      verify(permissionHandler.isPermissionGranted()).called(1);
      verify(listenChangesGPSUseCase.listenChangesGPS()).called(1);
    },
  );
}

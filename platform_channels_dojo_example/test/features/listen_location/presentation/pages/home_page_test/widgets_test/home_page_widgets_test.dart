import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:platform_channels_dojo_example/core/permission/permission_handler.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/listen_changes_GPS.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/start_location.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/stop_location.dart';
import 'package:platform_channels_dojo_example/features/listen_location/presentation/pages/home_page.dart';
import 'package:platform_channels_dojo_example/features/listen_location/presentation/provider/home_provider.dart';
import 'package:provider/provider.dart';

import '../mocks/test_mocks.mocks.dart';

void main() {
  late Widget homePageWidget;
  late Finder buttonAllowLocation;
  late Finder buttonStartAndStopButton;
  late Finder latitudeAndLongitudeText;

  late HomeProvider homeProvider;

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
          listenChangesGPSUseCase: listenChangesGPSUseCase)
        ..getPermissionLocation()
        ..listenChangesGPS();
    },
  );

  setUpAll(
    () {
      homePageWidget = MultiProvider(
        providers: [
          ChangeNotifierProvider<HomeProvider>(
            create: (_) => homeProvider,
          ),
        ],
        child: const MaterialApp(
          home: HomePage(),
        ),
      );

      buttonAllowLocation = find.byKey(const Key('allowLocation'));
      buttonStartAndStopButton = find.byKey(const Key('startAndStopButton'));
      latitudeAndLongitudeText =
          find.byKey(const Key('latitudeAndLongitudeInfo'));
    },
  );

  /// cuando se levanta la app por primera vez
  testWidgets(
    'GIVEN the first execution of the app'
    'WHEN the user has not yet granted the location permission'
    'THEN'
    '[the "Request Location Permission" button is visible,'
    'the "Start/Stop" button is disabled,'
    'the text "(0.0 ; 0.0)" is visible]',
    (WidgetTester tester) async {
      await tester.pumpWidget(homePageWidget);
      await tester.pumpAndSettle();
      expect(buttonAllowLocation, findsOneWidget);
      expect(
        tester.widget<ElevatedButton>(buttonStartAndStopButton).enabled,
        false,
      );
      expect(tester.widget<ElevatedButton>(buttonStartAndStopButton).onPressed,
          isNull);
      expect(find.text('(0.0 ; 0.0)'), findsOneWidget);
    },
  );

  /// el usuario NO concede permisos de ubicación
  testWidgets(
    'Given that the user presses the "Request Location Permission" button'
    'When the user does not grant the location permission'
    'Then'
    '[the "Request Location Permission" button is displayed,'
    'the "Start/Stop" button is disabled]',
    (WidgetTester tester) async {
      /// Arrange
      await tester.pumpWidget(homePageWidget);
      await tester.pumpAndSettle();

      /// Act
      when(
        permissionHandler.isPermissionGranted(),
      ).thenAnswer(
        (_) async => false,
      );

      /// Assert
      expect(buttonAllowLocation, findsOneWidget);

      expect(
        tester.widget<ElevatedButton>(buttonAllowLocation).enabled,
        true,
      );


    },
  );

  /// el usuario concede permisos de ubicación
  testWidgets(
    'GIVEN that the user presses the "Request Location Permission" button'
    'WHEN the user grants the location permission '
    'THEN'
    '[the "Start/Stop" button is enabled and has a green[400] color and the icon is play_arrow,'
    'the "Request Location Permission" button is not displayed,]',
    (WidgetTester tester) async {
      /// Arrange
      const expectedIcon = Icon(Icons.play_arrow);
      final expectedBackgroundColor = Colors.green[400];
      await tester.pumpWidget(homePageWidget);
      await tester.pumpAndSettle();
      await tester.tap(buttonAllowLocation);

      /// Act
      when(
        permissionHandler.isPermissionGranted(),
      ).thenAnswer(
        (_) async => true,
      );

      await homeProvider.getPermissionLocation();
      await tester.pump();

      /// Assert
      expect(
        tester.widget<ElevatedButton>(buttonStartAndStopButton).enabled,
        true,
      );
      expect(tester.widget<ElevatedButton>(buttonStartAndStopButton).onPressed,
          isNotNull);

      final actualProperty = tester
          .widget<ElevatedButton>(buttonStartAndStopButton)
          .style
          ?.backgroundColor
          ?.resolve(<MaterialState>{});

      expect(actualProperty, equals(equals(expectedBackgroundColor)));

      final actualIcon = tester
          .widget<ElevatedButton>(buttonStartAndStopButton)
          .child as Icon?;

      expect(actualIcon?.icon, expectedIcon.icon);

      expect(buttonAllowLocation, findsNothing);
    },
  );

  /// el usuario presiona el botón "Empezar a escuchar ubicación"
  ///TODO: mezclar este test con el anterior, existe coincidencia
  testWidgets(
    'When the user presses the "Start" button,'
    'Then '
    '[the "Start" button is enabled and colored red[400], and icon stop_rounded '
    'the text "(0.0 ; 0.0)" updates its value to the obtained coordinates]',
    (WidgetTester tester) async {
      /// Arrange
      /// TODO: usar Golden test para comparar la UI, pixel a pixel
      const expectedIcon = Icon(Icons.stop_rounded);
      final expectedBackgroundColor = Colors.red[400];
      await tester.pumpWidget(homePageWidget);
      await tester.pumpAndSettle();
      expect(find.text('(0.0 ; 0.0)'), findsOneWidget);

      /// Act
      when(
        permissionHandler.isPermissionGranted(),
      ).thenAnswer(
        (_) async => true,
      );

      when(listenChangesGPSUseCase.listenChangesGPS())
          .thenAnswer((_) => Stream.fromIterable([
                {"lat": -121.32567, "lon": 37.65933}
              ]));

      await homeProvider.getPermissionLocation();
      await homeProvider.listenChangesGPS();
      await tester.tap(buttonStartAndStopButton);
      /// checar esta linea, await homeProvider.startLocation();
     await homeProvider.startLocation();
// entender la diferencia entre .pump() y .pumpAndSettle()
      await tester.pump();

      /// Assert
      expect(
        tester.widget<ElevatedButton>(buttonStartAndStopButton).enabled,
        true,
      );



      final actualProperty = tester
          .widget<ElevatedButton>(buttonStartAndStopButton)
          .style
          ?.backgroundColor
          ?.resolve(<MaterialState>{});

      expect(actualProperty, equals(equals(expectedBackgroundColor)));

      final actualIcon = tester
          .widget<ElevatedButton>(buttonStartAndStopButton)
          .child as Icon?;

      expect(actualIcon?.icon, expectedIcon.icon);
      expect(find.text('(-121.32567 ; 37.65933)'), findsOneWidget);
    },
  );
}

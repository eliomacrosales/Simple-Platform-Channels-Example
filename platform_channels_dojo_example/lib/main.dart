import 'package:flutter/material.dart';
import 'package:platform_channels_dojo_example/features/listen_location/presentation/provider/home_provider.dart';
import 'package:provider/provider.dart';

import 'core/di/injection_container.dart';
import 'features/listen_location/presentation/pages/home_page.dart';
import 'core/di/injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => HomeProvider(
            startLocationUseCase: sl(),
            stopLocationUseCase: sl(),
            listenChangesGPSUseCase: sl(),
            permissionHandler: sl())
          ..getPermissionLocation()
          ..listenChangesGPS(),
      ),
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

import 'package:mockito/annotations.dart';
import 'package:platform_channels_dojo_example/core/permission/permission_handler.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/listen_changes_GPS.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/start_location.dart';
import 'package:platform_channels_dojo_example/features/listen_location/domain/usecases/stop_location.dart';

@GenerateNiceMocks([
  MockSpec<StartLocationUseCase>(),
  MockSpec<StopLocationUseCase>(),
  MockSpec<ListenChangesGPSUseCase>(),
  MockSpec<PermissionHandler>(),
])

void main() {}



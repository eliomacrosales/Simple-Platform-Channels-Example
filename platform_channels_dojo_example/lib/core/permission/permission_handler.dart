import 'package:permission_handler/permission_handler.dart';

abstract class PermissionHandler {
  Future<bool> isPermissionGranted();
}

class PermissionHandlerImpl implements PermissionHandler {
  @override
  Future<bool> isPermissionGranted() async {
    final status = await Permission.location.status;
    if (status == PermissionStatus.granted) {
      return true;
    } else {
      final statusRequest = await Permission.location.request();
      return statusRequest == PermissionStatus.granted;
    }
  }
}

import 'package:permission_handler/permission_handler.dart';

class PermissionHandler {
  static void requestCamera() async {
    var cameraStatus = await Permission.camera.status;
    if (cameraStatus.isDenied) {
      await Permission.camera.request();
    }
  }

  static void requestStorage() async {
    var storageStatus = await Permission.storage.status;
    if (storageStatus.isDenied) {
      await Permission.storage.request();
    }
  }

  static void requestLocation() async {
    var locationStatus = await Permission.location.status;
    if (locationStatus.isDenied) {
      await Permission.location.request();
    }
  }

  static void signUpPermissionRequest() async {
    await [
      Permission.camera,
      Permission.storage,
    ].request();
  }
}

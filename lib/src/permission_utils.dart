import 'package:permission_handler/permission_handler.dart';

extension PermissionExtension on Permission {
  Future<bool> requestAndCheck() async {
    final status = await request();
    return status.isGranted;
  }

  Future<bool> get isGrantedAsync async => await status.isGranted;

  Future<void> openSettingsIfPermanentlyDenied() async {
    if (await status.isPermanentlyDenied) {
      await openAppSettings();
    }
  }
}

class PermissionUtils {
  static Future<bool> handlePermission(Permission permission) async {
    if (await permission.isGrantedAsync) return true;

    final granted = await permission.requestAndCheck();
    if (!granted) {
      await permission.openSettingsIfPermanentlyDenied();
    }
    return granted;
  }
}

import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  Future<bool> requestGalleryPermission() async {
    if (Platform.isIOS) {
      return await Permission.photos.request().isGranted;
    }

    final sdkInt = await DeviceInfoPlugin().androidInfo.then((info) => info.version.sdkInt);
    if (sdkInt >= 33) {
      return await Permission.mediaLibrary.request().isGranted;
    } else {
      return await Permission.storage.request().isGranted;
    }
  }
}

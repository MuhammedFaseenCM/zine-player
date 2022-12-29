import 'dart:developer';

import 'package:permission_handler/permission_handler.dart';
import 'package:zineplayer/AccessFolders/MethodChannelfn.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';

List<String> AccessVideosPath = [];

Future<bool> _requestPermission(Permission permission) async {
  const storage = Permission.storage;
  const mediaAccess = Permission.accessMediaLocation;
  if (await permission.isGranted) {
    await mediaAccess.isGranted && await storage.isGranted;
    print("Permission granted");
    return true;
  } else {
    var result = await storage.request();
    var mediaresult = await mediaAccess.request();
    print("Permission request");

    if (result == PermissionStatus.granted &&
        mediaresult == PermissionStatus.granted) {
      return true;
    } else {
      return false;
    }
  }
}

Future splashFetch() async {
  log("object");
  if (await _requestPermission(Permission.storage)) {
    AccessFilesFromStorage.accessFromStorage([
      '.mp4',
      '.mkv',
    ], onSuccess, (p0) {});
  } else {
    splashFetch();
  }
}

onSuccess(List<String> path) {
  AccessVideosPath = path;
  for (var i = 0; i < AccessVideosPath.length; i++) {
    if (AccessVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      AccessVideosPath.remove(AccessVideosPath[i]);
      i--;
    }
  }
  loadFolderList();

  print(AccessVideosPath.length);
}

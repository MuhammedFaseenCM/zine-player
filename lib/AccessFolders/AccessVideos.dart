import 'dart:developer';
import 'package:permission_handler/permission_handler.dart';
import 'package:zineplayer/AccessFolders/MethodChannelfn.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';

List<String> accessVideosPath = [];

Future<bool> _requestPermission(Permission permission) async {
  const storage = Permission.storage;
  const mediaAccess = Permission.accessMediaLocation;
  if (await permission.isGranted) {
    await mediaAccess.isGranted && await storage.isGranted;
    return true;
  } else {
    var result = await storage.request();
    var mediaresult = await mediaAccess.request();

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
      '.mkv',
      '.mp4',
    ], onSuccess, (p0) {});
  } else {
    splashFetch();
  }
}

onSuccess(List<String> path) {
  accessVideosPath = path;
  for (var i = 0; i < accessVideosPath.length; i++) {
    if (accessVideosPath[i].startsWith('/storage/emulated/0/Android/data')) {
      accessVideosPath.remove(accessVideosPath[i]);
      i--;
    }
  }
  loadFolderList();
  loadVideoList();
}

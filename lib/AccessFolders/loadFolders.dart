import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';

ValueNotifier<List<String>> loadFolders = ValueNotifier([]);
List<String> temp = [];
List<String> foldertitle = [];

Future loadFolderList() async {
  loadFolders.value.clear();
  for (String path in accessVideosPath) {
    temp.add(path.substring(0, path.lastIndexOf('/')));
  }
  loadFolders.value = temp.toSet().toList();
}

import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';

ValueNotifier<List<String>> loadFolders = ValueNotifier([]);
List<String> temp = [];
List<String> foldertitle = [];

Future loadFolderList() async {
  print("Loading folder list");
  loadFolders.value.clear();
  for (String path in AccessVideosPath) {
    temp.add(path.substring(0, path.lastIndexOf('/')));
  }
  loadFolders.value = temp.toSet().toList();
}

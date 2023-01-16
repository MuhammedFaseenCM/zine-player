import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addItemToPlayList(
    {required playlistFolderName, required videoPath, required context,required duration}) async {
  final list = PlayListItems(
      playlistFolderName: playlistFolderName, videoPath: videoPath, duration: duration);
  final listitemshive = await Hive.openBox<PlayListItems>('listitemsBox');
  List<PlayListItems> playlist = listitemshive.values.toList();
  List<PlayListItems> result = playlist
      .where((element) =>
          element.videoPath == videoPath &&
          element.playlistFolderName == playlistFolderName)
      .toList();
  if (videoPath.isEmpty) {
    return;
  } else if (result.isNotEmpty) {
    snackBar(
        context: context, content: videoExists, bgcolor: grey);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  } else {
    playlistitemDB(list);
    snackBar(context: context, content:added, bgcolor: green);
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}

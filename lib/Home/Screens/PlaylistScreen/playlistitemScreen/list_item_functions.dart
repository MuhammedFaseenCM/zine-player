import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addItemToPlayList({required playlistFolderName, required videoPath, required context}) {
  final list = PlayListItems(playlistFolderName: playlistFolderName, videoPath: videoPath);
  if (videoPath.isEmpty) {
    return;
  }
  playlistitemDB(list);

  Navigator.of(context).pop();
  Navigator.of(context).pop();
}

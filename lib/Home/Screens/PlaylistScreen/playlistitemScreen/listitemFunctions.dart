import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addItemToPlayList({required title, required context}) {
  final list = PlayListItems(title: title);
  if (title.isEmpty) {
    return;
  }
  print("$title added to playlist");
  playlistitemDB(list);

  Navigator.of(context).pop();
  Navigator.of(context).pop();
}

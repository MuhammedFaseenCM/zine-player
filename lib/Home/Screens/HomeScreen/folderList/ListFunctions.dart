import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addToFavourite({required title, required context, index}) async {
  final name = title;
  final favList = Favourite(title: name);
  if (name == null) {
    return;
  }
  print(name);
  favouriteDB(favList, context, title);
  getFavList();
}

addToRecentList({required title, required context}) async {
  final name = title;
  final resList = RecentList(title: name);
  if (name == null) {
    return;
  }
  print(name);
  recentListDB(resList);
  getRecentList();
}

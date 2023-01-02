import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addToFavourite(
    {required title, required context, index, required videoPath}) async {
  final favouritehive = await Hive.openBox<Favourite>('favouriteBox');
  List<Favourite> favListing = favouritehive.values.toList();
  log(favListing.toString());
  List<Favourite> result =
      favListing.where((contains) => contains.videoPath == videoPath).toList();
  log(result.toString());

  if (result.isEmpty) {
    final name = title;
    final favList = Favourite(title: name, videoPath: videoPath);
    if (name == null) {
      return;
    }
    print(name);
    favouriteDB(favList, context);
    getFavList();
  } else {
    snackBar(
        context: context,
        content: "Already added to favourite list",
        bgcolor: Colors.grey[800]);
    Navigator.of(context).pop();
    return;
  }
}

addToRecentList({required title, required context, required videoPath}) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  List<RecentList> recListing = recentlisthive.values.toList();
  List<RecentList> result =
      recListing.where((contains) => contains.videoPath == videoPath).toList();
  log(result.toString());
  log(recListing.toString());
  if (result.isEmpty) {
    final name = title;
    final resList = RecentList(videoPath: videoPath);
    if (name == null) {
      return;
    }
    print(name);
    recentListDB(resList);
    getRecentList();
  } else {
    return;
  }
}

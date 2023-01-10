import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

addToFavourite(
    {required title, required context, index, required videoPath}) async {
  final favouritehive = await Hive.openBox<Favourite>('favouriteBox');
  List<Favourite> favListing = favouritehive.values.toList();
  List<Favourite> result =
      favListing.where((contains) => contains.videoPath == videoPath).toList();
  if (result.isEmpty) {
    final name = title;
    final favList = Favourite(title: name, videoPath: videoPath);
    if (name == null) {
      return;
    }
    favouriteDB(favList, context);
  } else {
    snackBar(
        context: context, content: "Already added", bgcolor: Colors.grey[800]);
    return;
  }
}

addToRecentList(
    {required title,
    required context,
    required videoPath,
    required recentduration,
    required durationinSec}) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  List<RecentList> recListing = recentlisthive.values.toList();
  List<RecentList> result =
      recListing.where((contains) => contains.videoPath == videoPath).toList();
  final resList = RecentList(
      videoPath: videoPath,
      duration: recentduration,
      durationinSec: durationinSec);
  if (videoPath == null) {
    return;
  }
  if (result.isNotEmpty) {
    int index =
        recListing.indexWhere((element) => element.videoPath == videoPath);
    recentlisthive.putAt(index, resList);
    getRecentList();
    recentListNotifier.notifyListeners();
  }
  if (result.isEmpty) {
    recentListDB(resList);
  } else {
    return;
  }
}

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/functions/datamodels.dart';

ValueNotifier<List<PlayList>> playListNotifier = ValueNotifier([]);
ValueNotifier<List<Favourite>> favouriteNotifier = ValueNotifier([]);
ValueNotifier<List<PlayListItems>> playlistitemsNotifier = ValueNotifier([]);
ValueNotifier<List<RecentList>> recentListNotifier = ValueNotifier([]);

playlistdb(PlayList value) async {
  final playlisthive = await Hive.openBox<PlayList>('playlistBox');
  final id = await playlisthive.add(value);
  value.index = id;
  playListNotifier.value.add(value);
  playListNotifier.notifyListeners();
}

Future<void> getPlayList() async {
  final playlisthive = await Hive.openBox<PlayList>('playlistBox');

  playListNotifier.value.clear();
  playListNotifier.value.addAll(playlisthive.values);
  print('Number of playlist \t');
  print(playlisthive.values.length);
  playListNotifier.notifyListeners();
}

Future<void> deletePlayList(int index) async {
  final playlisthive = await Hive.openBox<PlayList>('playlistBox');
  await playlisthive.deleteAt(index);
  getPlayList();
}

Future<void> updatePlayList(PlayList value, int index) async {
  final playlisthive = await Hive.openBox<PlayList>('playlistBox');
  await playlisthive.putAt(index, value);
  getPlayList();
}

favouriteDB(Favourite value, context, title) async {
  final favouritehive = await Hive.openBox<Favourite>('favouriteBox');
  if (!favouritehive.containsKey(title)) {
    final id = await favouritehive.add(value);
    value.index = id;
    favouriteNotifier.value.add(value);
    favouriteNotifier.notifyListeners();
    snackBar(
        context: context, content: "Successfully added", bgcolor: Colors.green);
    Navigator.of(context).pop();
  } else {
    snackBar(
        context: context,
        content: "Already added to favourite list",
        bgcolor: Colors.grey[800]);
    Navigator.of(context).pop();
  }
}

Future<void> getFavList() async {
  final favlisthive = await Hive.openBox<Favourite>('favouriteBox');
  favouriteNotifier.value.clear();
  favouriteNotifier.value.addAll(favlisthive.values);
  print("Number of items in favourite list");

  print(favlisthive.values.length);
  favouriteNotifier.notifyListeners();
}

Future<void> deleteFav(int index) async {
  final favlisthive = await Hive.openBox<Favourite>('favouriteBox');
  await favlisthive.deleteAt(index);
  print("deleted $index from favouritelist");
  getFavList();
}

playlistitemDB(PlayListItems value) async {
  final listitemshive = await Hive.openBox<PlayListItems>('listitemsBox');
  final id = await listitemshive.add(value);
  value.index = id;
  playlistitemsNotifier.value.add(value);
  playlistitemsNotifier.notifyListeners();
}

Future<void> getPlayListitems() async {
  final listitemshive = await Hive.openBox<PlayListItems>('listitemsBox');
  playlistitemsNotifier.value.clear();
  playlistitemsNotifier.value.addAll(listitemshive.values);
  print("Number of items in playlist \t");
  print(listitemshive.values.length);
  playlistitemsNotifier.notifyListeners();
}

Future<void> deleteListItem({required int index, required context}) async {
  final listitemshive = await Hive.openBox<PlayListItems>('listitemsBox');
  await listitemshive.deleteAt(index);
  print("deleted $index from playlist");
  Navigator.of(context).pop();
  await getPlayListitems();
}

Future<void> getAllFunctions() async {
  getFavList();
  getPlayList();
  getPlayListitems();
  getRecentList();
}

recentListDB(RecentList value) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  await recentlisthive.add(value);
  recentListNotifier.value.add(value);
  recentListNotifier.notifyListeners();
}

Future<void> getRecentList() async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  recentListNotifier.value.clear();
  recentListNotifier.value.addAll(recentlisthive.values);
  print("Number of items in recent list \t");
  print(recentlisthive.values.length);
  recentListNotifier.notifyListeners();
}

Future<void> deleteRecentList(context) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  if (recentlisthive.isNotEmpty) {
    await recentlisthive.deleteAll(recentlisthive.keys);
    print("Recent list cleared");
    snackBar(
        context: context,
        content: "Successfully cleared",
        bgcolor: Colors.green);
  } else {
    print("recentlist is empty");
    snackBar(
        context: context,
        content: "Recent list is empty",
        bgcolor: Colors.grey[800]);
  }

  getRecentList();
}

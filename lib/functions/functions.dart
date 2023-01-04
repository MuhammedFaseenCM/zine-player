import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen.dart';
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

favouriteDB(Favourite value, context) async {
  final favouritehive = await Hive.openBox<Favourite>('favouriteBox');
  final id = await favouritehive.add(value);
  value.index = id;
  favouriteNotifier.value.add(value);
  favouriteNotifier.notifyListeners();
  snackBar(
      context: context, content: "Successfully added", bgcolor: Colors.green);
  Navigator.of(context).pop();
}

Future<void> getFavList() async {
  final favlisthive = await Hive.openBox<Favourite>('favouriteBox');
  favouriteNotifier.value.clear();
  favouriteNotifier.value.addAll(favlisthive.values);
  favouriteNotifier.notifyListeners();
}

Future<void> deleteFav(int index) async {
  final favlisthive = await Hive.openBox<Favourite>('favouriteBox');
  await favlisthive.deleteAt(index);
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
  playlistitemsNotifier.notifyListeners();
}

Future<void> deleteListItem({required int index, required context}) async {
  final listitemshive = await Hive.openBox<PlayListItems>('listitemsBox');
  await listitemshive.deleteAt(index);
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
  final id = await recentlisthive.add(value);
  value.index = id;
  recentListNotifier.value.add(value);
  recentListNotifier.notifyListeners();
}

updaterecentDB(RecentList value, int index) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  await recentlisthive.putAt(index, value);
  await getRecentList();
}

Future<void> getRecentList() async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  recentListNotifier.value.clear();
  recentListNotifier.value.addAll(recentlisthive.values);
  recentListNotifier.notifyListeners();
}

Future<void> deleteRecentList(context) async {
  final recentlisthive = await Hive.openBox<RecentList>('recentlistBox');
  if (recentlisthive.isNotEmpty) {
    await recentlisthive.deleteAll(recentlisthive.keys);

    snackBar(
        context: context,
        content: "Successfully cleared",
        bgcolor: Colors.green);
  } else {
    snackBar(
        context: context,
        content: "Recent list is empty",
        bgcolor: Colors.grey[800]);
  }

  getRecentList();
}

playVideo(
    {required videotitle,
    required context,
    required videoPath,
    required splittedvideotitle,
    required recentduration}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return PlayScreen(
        videoFile: videoPath,
        videotitle: splittedvideotitle,
      );
    },
  ));
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

splittedvideofunction(splittedvideotitle) {
  if (splittedvideotitle.length > 20) {
    splittedvideotitle = "${splittedvideotitle.substring(0, 20)}...";
  }
}

Future<void> snackBar(
    {required BuildContext context, required content, required bgcolor}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: bgcolor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
  ));
}

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
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
  await listitemshive.add(value);
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

    snackBar(context: context, content: "Successfully cleared", bgcolor: green);
  } else {
    snackBar(
        context: context,
        content: "Recent list is empty",
        bgcolor: Colors.grey[800]);
  }

  getRecentList();
}

Future<void> pickColor({value}) async {
  final colorhive = await Hive.openBox<FrameColor>('colorBox');
  if (colorhive.isEmpty) {
    value = FrameColor(color: "Color(0x968383)");
    await colorhive.add(value);
    log("add");
  } else {
    log("put");
    await colorhive.putAt(0, value);
  }
  log("picked color: ${value.toString()}");
}

playVideo(
    {required videotitle,
    required context,
    required videoPath,
    required splittedvideotitle,
    durationinSec}) {
  Navigator.of(context).push(MaterialPageRoute(
    builder: (context) {
      return PlayScreen(
        videoFile: videoPath,
        videotitle: splittedvideotitle,
        duration: durationinSec ?? 0,
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
    {required BuildContext context,
    required content,
    required bgcolor,
    function}) async {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(content),
    backgroundColor: bgcolor,
    behavior: SnackBarBehavior.floating,
    margin: const EdgeInsets.all(10),
    action: SnackBarAction(
      label: 'ok',
      onPressed: () {
        function;
      },
      textColor: Colors.white,
    ),
  ));
}

Route createRoute(page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

checkthumbnail() async {
  if (0 == 0) {
  } else {}
}

getthumbnail(path, setState) async {
  thumbnailFile = (await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG))!;
  setState(() {});
}

Widget thumbnail({duration}) {
  return Stack(
    children: [
      Container(
          height: 50.0,
          width: 90.0,
          color: black,
          child: Image.file(File(thumbnailFile))),
      Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            color: black,
            child: duration != null
                ? Text(
                    duration.toString().split("0:0").last,
                    style: const TextStyle(color: Colors.white, fontSize: 11.0),
                  )
                : null,
          ))
    ],
  );
}

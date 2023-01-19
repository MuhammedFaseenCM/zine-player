import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/FavScreen/fav_screen.dart';
import 'package:zineplayer/Home/Search%20pages/search_favourite.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/folder_home.dart';
import 'package:zineplayer/Home/Search%20pages/search_folder.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/bottom_nav.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/side_bar.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/play_list_screen.dart';
import 'package:zineplayer/Home/Search%20pages/search_playlist.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recently_screen.dart';
import 'package:zineplayer/Home/Search%20pages/search_recent.dart';
import 'package:zineplayer/Home/Search%20pages/search_videos.dart';
import 'package:zineplayer/Home/Screens/videoscreen/video_home.dart';
import 'package:zineplayer/Home/Screens/pip_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static ValueNotifier<int> selectedNotifier = ValueNotifier(0);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [
    const VideoHome(),
    const FolderHome(),
    const RecentScreen(),
    const FavouriteScreen(),
    const PlayScreen()
  ];
  int index = 0;
  String? videoPath;
  String? videotitle;
  String? splittedvideotitle;
  int? durationinSecs;

  @override
  void initState() {
    getAllFunctions();
    super.initState();
    recentdbdata();
  }

  recentdbdata() async {
    final box = await Hive.openBox<RecentList>('recentlistBox');
    List<RecentList> data = box.values.toList();

    if (data.isNotEmpty) {
      durationinSecs = data.last?.durationinSec;
      videoPath = data.last?.videoPath;
      videotitle = videoPath?.split("/").last;
      splittedvideotitle = videotitle;
      if (splittedvideotitle!.length > 20) {
        splittedvideotitle = "${videotitle!.substring(0, 20)}...";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await recentdbdata();
            if (videoPath != null) {
              playVideo(
                  videotitle: videotitle,
                  context: context,
                  videoPath: videoPath,
                  splittedvideotitle: splittedvideotitle,
                  durationinSec: durationinSecs);
            } else {
              return;
            }
          },
          backgroundColor: purplecolor,
          child: const Icon(Icons.play_arrow),
        ),
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: MainScreen.selectedNotifier,
            builder: (BuildContext ctx, int updatedIndex, _) {
              index = updatedIndex;
              return Text(appbar[updatedIndex]);
            },
          ),
          backgroundColor: transparent,
          flexibleSpace: appbarcontainer(),
          centerTitle: true,
          actions: [
            // IconButton(
            //     onPressed: () => splashFetch(),
            //     icon: const Icon(Icons.rotate_left)),
            IconButton(
                onPressed: () {
                  searchingFunc();
                },
                icon: const Icon(Icons.search))
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: Stack(children: [
          ValueListenableBuilder(
              valueListenable: MainScreen.selectedNotifier,
              builder: (BuildContext ctx, int updatedIndex, _) =>
                  _pages[updatedIndex]),
          //   pipScreen()
        ]),
      ),
    );
  }

  Widget pipScreen() {
    if (videoPath == null) {
      return const SizedBox();
    } else {
      return PipScreen(videoPath: videoPath!);
    }
  }

  searchingFunc() {
    if (index == 0) {
      showSearch(context: context, delegate: VideoSearch());
    } else if (index == 1) {
      showSearch(context: context, delegate: FolderSearch());
    } else if (index == 2) {
      showSearch(context: context, delegate: RecentSearch());
    } else if (index == 3) {
      showSearch(context: context, delegate: FavSearch());
    } else if (index == 4) {
      showSearch(context: context, delegate: Search());
    }
  }
}

Widget appbarcontainer() {
  return Container(
      decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
             ),
          gradient: LinearGradient(colors: [bluecolor, purplecolor])));
}

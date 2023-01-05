import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/fav_screen.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/folder_home.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/bottom_nav.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/side_bar.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/play_list_screen.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/search_playlist.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recently_screen.dart';
import 'package:zineplayer/Home/Screens/videoscreen/video_home.dart';
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

  @override
  void initState() {
    getAllFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: MainScreen.selectedNotifier,
            builder: (BuildContext ctx, int updatedIndex, _) {
              return Text(_appbar[updatedIndex]);
            },
          ),
          backgroundColor: Colors.transparent,
          flexibleSpace: appbarcontainer(),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        bottomNavigationBar: const BottomNavBar(),
        body: ValueListenableBuilder(
          valueListenable: MainScreen.selectedNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return _pages[updatedIndex];

            //_pages[updatedIndex];
          },
        ),
      ),
    );
  }

  final _appbar = [
    'Home',
    'Folder list',
    'Recentlist',
    'Liked videos',
    'Playlist'
  ];
}

Widget appbarcontainer() {
  return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple])));
}

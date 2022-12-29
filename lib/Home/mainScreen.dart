import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favScreen.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/FolderHome.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/bottom_nav.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/side_bar.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/PlaylistScreen.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/homeScreen.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/search_playlist.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/RecentlyScreen.dart';
import 'package:zineplayer/functions/functions.dart';

class MainScreen extends StatefulWidget {
  MainScreen({super.key});
  static ValueNotifier<int> selectedNotifier = ValueNotifier(0);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final _pages = [
    FolderHome(),
    const RecentScreen(),
    const FavouriteScreen(),
    PlayScreen()
  ];

  @override
  void initState() {
    // TODO: implement initState
    getAllFunctions();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
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
        body: SafeArea(
            child: ValueListenableBuilder(
          valueListenable: MainScreen.selectedNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return _pages[updatedIndex];

            //_pages[updatedIndex];
          },
        )),
      ),
    );
  }

  final _appbar = ['Home', 'Recentlist', 'Favourites', 'Playlist'];
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

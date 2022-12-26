import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favScreen.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/bottom_nav.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/side_bar.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/PlaylistScreen.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/homeScreen.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/search_playlist.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/RecentlyScreen.dart';
import 'package:zineplayer/functions/functions.dart';

class MainScreen extends StatelessWidget {
  MainScreen({super.key});
  static ValueNotifier<int> selectedNotifier = ValueNotifier(0);

  final _pages = [
    Home_screen(),
    const RecentScreen(),
    const FavouriteScreen(),
    PlayScreen()
  ];

  @override
  Widget build(BuildContext context) {
    getAllFunctions();
    return SafeArea(
      child: Scaffold(
        drawer: NavDrawer(),
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: selectedNotifier,
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
          valueListenable: selectedNotifier,
          builder: (BuildContext ctx, int updatedIndex, _) {
            return _pages[updatedIndex];

            //_pages[updatedIndex];
          },
        )),
      ),
    );
  }

  final _appbar = ['Home', 'Recent', 'Favourites', 'Playlist'];
}

Widget appbarcontainer() {
  return Container(
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
              topRight: Radius.circular(20.0)),
          gradient: LinearGradient(colors: [Colors.red, Colors.purple])));
}

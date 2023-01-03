import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zineplayer/Home/mainScreen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedNotifier,
      builder: (BuildContext context, int updatedIndex, _) {
        return CurvedNavigationBar(
            backgroundColor: Colors.white,
            color: Colors.blue,
            onTap: (newIndex) {
              MainScreen.selectedNotifier.value = newIndex;
            },
            items: [
              bottomNavIcon(Icons.home),
              bottomNavIcon(Icons.folder),
              bottomNavIcon(Icons.restore),
              bottomNavIcon(Icons.favorite),
              bottomNavIcon(Icons.playlist_play)
              // Icon(Icons.folder),
              // Icon(Icons.restore),
              // Icon(Icons.favorite),
              // Icon(Icons.playlist_play)
              // BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.timer), label: 'Recent list'),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.favorite), label: 'Favourites'),
              // BottomNavigationBarItem(
              //     icon: Icon(Icons.playlist_play), label: 'Playlist'),
            ]);
      },
    );
  }

  Widget bottomNavIcon(icon) {
    return Icon(
      icon,
      color: Colors.white,
    );
  }
}

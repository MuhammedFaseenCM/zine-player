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
            color: Colors.white,
            onTap: (newIndex) {
              MainScreen.selectedNotifier.value = newIndex;
            },
            items: const [
              Icon(
                Icons.home,
              ),
              Icon(Icons.restore),
              Icon(Icons.favorite),
              Icon(Icons.playlist_play)
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
}

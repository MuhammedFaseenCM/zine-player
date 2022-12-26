import 'package:flutter/material.dart';
import 'package:zineplayer/Home/mainScreen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedNotifier,
      builder: (BuildContext context, int updatedIndex, _) {
        return BottomNavigationBar(
            selectedItemColor: Colors.purple,
            unselectedItemColor: Colors.grey[700],
            currentIndex: updatedIndex,
            onTap: (newIndex) {
              MainScreen.selectedNotifier.value = newIndex;
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.timer), label: 'Recent list'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.favorite), label: 'Favourites'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.playlist_play), label: 'Playlist'),
            ]);
      },
    );
  }
}

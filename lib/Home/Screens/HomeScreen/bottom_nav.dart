import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/main_screen.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: MainScreen.selectedNotifier,
      builder: (BuildContext context, int updatedIndex, _) {
        return CurvedNavigationBar(
            backgroundColor: white,
            color:bluecolor,
            onTap: (newIndex) {
              MainScreen.selectedNotifier.value = newIndex;
            },
            items: [
              bottomNavIcon(Icons.home),
              bottomNavIcon(Icons.folder),
              bottomNavIcon(Icons.restore),
              bottomNavIcon(Icons.favorite),
              bottomNavIcon(Icons.playlist_play)
            ]);
      },
    );
  }

  Widget bottomNavIcon(icon) {
    return Icon(
      icon,
      color: white,
    );
  }
}

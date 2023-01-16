import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/privacy_terms.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/settings.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.play_circle,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  Text(
                    zineplayer,
                    style: const TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.settings),
                    title: const Text('Settings'),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ))
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Rate us'),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('about us'),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) {
                          return const AboutUs();
                        },
                      ))
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.android,
                      color: green,
                    ),
                    title: const Text("Version 1.0.0"),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}

void termsAndConditions(context, title, text) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(title),
        content: detailsDailog(text),
      );
    },
  );
}

Widget detailsDailog(text) {
  return SizedBox(
    height: 500.0,
    width: 300.0,
    child: SingleChildScrollView(child: Text(text)),
  );
}

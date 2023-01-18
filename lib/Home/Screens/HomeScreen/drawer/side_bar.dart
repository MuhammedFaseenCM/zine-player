import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/settings.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              gradient: LinearGradient(colors: [green, purplecolor]),
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/image/play_icon_3.png',
                    width: 50,
                  ),
                  Text(
                    zineplayer,
                    style: TextStyle(
                        fontSize: 25,
                        foreground: Paint()..shader = linearGradient),
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
                    leading: const Icon(Icons.file_open),
                    title: const Text("T & C"),
                    onTap: () => termsAndConditions(
                        context, "Terms and conditions", termsandconditions),
                  ),
                  ListTile(
                    leading: const Icon(Icons.key),
                    title: const Text("Privacy policy"),
                    onTap: () => termsAndConditions(
                        context, "Privacy policy", privacypolicy),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: const Text('Rate us'),
                    onTap: () => {
                    
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: const Text('about us'),
                    onTap: () => {aboutUS(context)},
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
        content: detailsDailog(text, context),
      );
    },
  );
}

Widget detailsDailog(text, context) {
  return SizedBox(
      height: 500.0,
      width: 300.0,
      child: SingleChildScrollView(
          child: RichText(
        text: TextSpan(
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(text: text),
              const TextSpan(
                text: 'faseencm0@gmail.com',
                style: TextStyle(
                    color: Colors.blue, decoration: TextDecoration.underline),
              )
            ]),
      )));
}

void aboutUS(context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Row(
          children: [
            Image.asset(
              'assets/image/play_icon_3.png',
              width: 50,
            ),
            Column(
              children: [
                Text(zineplayer),
                const Text(
                  "1.0.0",
                  style:
                      TextStyle(fontWeight: FontWeight.normal, fontSize: 15.0),
                )
              ],
            ),
          ],
        ),
        content: aboutUSDailog(),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Close"))
        ],
      );
    },
  );
}

Widget aboutUSDailog() {
  return const SizedBox(
    height: 50.0,
    width: 300.0,
    child: SingleChildScrollView(
        child: Center(
      child: Text(
        "Zine player is a video player\ncreated by Muhammed Faseen C M",
        style: TextStyle(fontWeight: FontWeight.normal),
      ),
    )),
  );
}

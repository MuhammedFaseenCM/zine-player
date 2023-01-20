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
                    launcherIcon,
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
                    title: Text(settingsText),
                    onTap: () => {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const Settings(),
                      ))
                    },
                  ),
                  ListTile(
                    leading: const Icon(Icons.file_open),
                    title: Text(tnC),
                    onTap: () =>
                        termsAndConditions(context, tnC, termsandconditions),
                  ),
                  ListTile(
                    leading: const Icon(Icons.key),
                    title: Text(pnC),
                    onTap: () =>
                        termsAndConditions(context, pnC, privacypolicy),
                  ),
                  ListTile(
                    leading: const Icon(Icons.star),
                    title: Text(rateUS),
                    onTap: () => {},
                  ),
                  ListTile(
                    leading: const Icon(Icons.person),
                    title: Text(about),
                    onTap: () => {aboutUS(context)},
                  ),
                ],
              ),
              Container(
                  margin: const EdgeInsets.only(bottom: 0, left: 40),
                  child: Column(
                    children: [
                      ListTile(
                        title: Row(
                          children: [
                            Icon(
                              Icons.android,
                              color: green,
                            ),
                            Text(version),
                          ],
                        ),
                      )
                    ],
                  )),
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
              TextSpan(
                text: mailID,
                style: TextStyle(
                    color: bluecolor, decoration: TextDecoration.underline),
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
              launcherIcon,
              width: 50,
            ),
            Column(
              children: [
                Text(zineplayer),
                Text(
                  version,
                  style: const TextStyle(
                      fontWeight: FontWeight.normal, fontSize: 15.0),
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
              child: Text(closeText))
        ],
      );
    },
  );
}

Widget aboutUSDailog() {
  return SizedBox(
    height: 50.0,
    width: 300.0,
    child: SingleChildScrollView(
        child: Center(
      child: Text(
        aboutUSDetails,
        style: const TextStyle(fontWeight: FontWeight.normal),
      ),
    )),
  );
}

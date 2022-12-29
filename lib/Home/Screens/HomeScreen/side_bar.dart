import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
              //image: DecorationImage(
              //   fit: BoxFit.fill,
              //  image: AssetImage('assets/images/cover.jpg')
              // )
            ),
            child: Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.play_circle,
                    size: 35.0,
                    color: Colors.white,
                  ),
                  Text(
                    'Zine player',
                    style: TextStyle(color: Colors.white, fontSize: 25),
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
                    leading: Icon(Icons.settings),
                    title: Text('Settings'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  ListTile(
                    leading: Icon(Icons.border_color),
                    title: Text('Feedback'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('about'),
                    onTap: () => {Navigator.of(context).pop()},
                  ),
                ],
              ),
              Column(
                children: const [
                  ListTile(
                    leading: Icon(
                      Icons.android,
                      color: Colors.green,
                    ),
                    title: Text("Version 1.0.0"),
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

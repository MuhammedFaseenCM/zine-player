import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/side_bar.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/main_screen.dart';

class AboutUs extends StatelessWidget {
  const AboutUs({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("About us"),
        backgroundColor: transparent,
        flexibleSpace: appbarcontainer(),
        centerTitle: true,
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text("Terms and conditions",
                style: TextStyle(fontWeight: FontWeight.bold)),
            onTap: () {
              termsAndConditions(
                  context, "Terms and conditions", termsandconditions);
            },
          ),
          ListTile(
            title: const Text(
              "Privacy policy",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            onTap: () {
              termsAndConditions(
                context,
                "Privacy policy",
                privacypolicy,
              );
            },
          )
        ],
      ),
    );
  }
}

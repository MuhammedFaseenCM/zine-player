import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/main_screen.dart';
import 'package:zineplayer/functions/functions.dart';
import 'package:zineplayer/main.dart';

bool isloading = false;

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [bluecolor, purplecolor])),
        child: Container(
          width: 100,
          height: 100,
          //    margin: const EdgeInsets.only(top: 200),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/image/play_icon_3.png',
                width: 150,
              ),
              Text(
                zineplayer,
                style: TextStyle(
                    color: white, fontSize: 30.0, fontWeight: FontWeight.bold),
              ),
              Text(
                "WELCOMES YOU",
                style: TextStyle(
                    color: white, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                "Enjoy the powerful video player with advanced features",
                textAlign: TextAlign.center,
                style: TextStyle(color: white, fontSize: 13.0),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 250,
                ),
                child: ElevatedButton(
                    onPressed: () {
                      checkSplashFetch(context);
                    },
                    child: const Text("Let's go!")),
              ),
              isloading ? const CircularProgressIndicator() : const SizedBox()
            ],
          ),
        ),
      ),
    );
  }

  checkSplashFetch(BuildContext context) async {
    setState(() {
      isloading = true;
    });
    await splashFetch();
    await Future.delayed(const Duration(seconds: 7));
    Navigator.of(context).pushReplacement(createRoute(
      const MainScreen(),
    ));

    final sharefPrefs = await SharedPreferences.getInstance();
    await sharefPrefs.setBool(SAVE_KEY_NAME, true);
  }
}

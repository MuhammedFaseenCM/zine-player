import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/main_screen.dart';
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
        child: SizedBox(
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
                    fontSize: 35.0,
                    fontWeight: FontWeight.bold,
                    foreground: Paint()..shader = linearGradient),
              ),
              Text(
                "WELCOMES YOU",
                style: TextStyle(
                    color: white, fontSize: 15.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Container(
                height: 1.0,
                width: 380.0,
                color: white,
              ),
              AnimatedTextKit(animatedTexts: [
                TyperAnimatedText(
                  "Enjoy the powerful video player with advanced features",
                  speed: const Duration(milliseconds: 100),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: white,
                    fontSize: 13.0,
                  ),
                )
              ]),
              Container(
                height: 1.0,
                width: 380.0,
                color: white,
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
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(createRoute(
      const MainScreen(),
    ));

    final sharefPrefs = await SharedPreferences.getInstance();
    await sharefPrefs.setBool(saveKey, true);
  }
}


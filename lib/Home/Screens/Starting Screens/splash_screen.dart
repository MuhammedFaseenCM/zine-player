import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/main_screen.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/welcome.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => SplashscreenState();
}

class SplashscreenState extends State<SplashScreen> {
  double percent = 0.1;
  @override
  void initState() {
    splashFetch();
    indicator();
    checklogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [bluecolor, purplecolor])),
      child: Column(
        children: [
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset(
                    launcherIcon,
                    width: 150,
                  ),
                  Text(
                    zineplayer,
                    style: TextStyle(
                        foreground: Paint()..shader = linearGradient,
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: Column(
            children: [
              Container(
                width: 200.0,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100.0),
                ),
                child: LinearPercentIndicator(
                  width: 200.0,
                  backgroundColor: bluecolor,
                  lineHeight: 5.0,
                  percent: percent,
                  progressColor: white,
                  barRadius: const Radius.circular(16),
                ),
              )
            ],
          ))
        ],
      ),
    ));
  }

  Future<void> gotoMainScreen() async {
    await Future.delayed(const Duration(seconds: 7));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const MainScreen()));
  }

  Future<void> indicator() async {
    for (int i = 1; i < 18; i++) {
      await Future.delayed(const Duration(milliseconds: 100));
      setState(() {
        percent = percent;
      });
      percent = percent + 0.05;
    }
  }

  Future<void> checklogin() async {
    final sharedprefs = await SharedPreferences.getInstance();
    final userLoggedIn = sharedprefs.getBool(keyValue);
    if (userLoggedIn == null || userLoggedIn == false) {
      // ignore: use_build_context_synchronously
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (ctx1) => const Welcome()));
    } else {
      gotoMainScreen();
    }
  }
}

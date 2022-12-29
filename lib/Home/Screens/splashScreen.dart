import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';
import 'package:zineplayer/Home/mainScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _Splash_screenState();
}

class _Splash_screenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    splashFetch();
    gotoMainScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
            gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Icon(
                Icons.play_circle,
                size: 50.0,
                color: Colors.white,
              ),
              Text(
                'Zine player',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold),
              )
            ],
          ),
        ),
      ),
    ));
  }

  Future<void> gotoMainScreen() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
  }
}

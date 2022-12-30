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
        body: Container(
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [Colors.blue, Colors.purple])),
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(
                      Icons.play_circle,
                      size: 80.0,
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
          ),
          Expanded(
              child: Column(
            children: const [
              SizedBox(
                width: 200.0,
                child: LinearProgressIndicator(
                  color: Colors.white,
                  // value: .1,
                  semanticsValue: "Loading",
                  semanticsLabel: "Loading",
                  backgroundColor: Colors.blue,
                  minHeight: 5.0,
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
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) => MainScreen()));
  }
}

import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/main_screen.dart';

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
    gotoMainScreen();
    super.initState();
  }

  Future<void> indicator() async {
    for (int i = 1; i < 8; i++) {
      await Future.delayed(const Duration(seconds: 1));
      setState(() {
        percent = percent;
      });
      percent = percent + 0.12;
    }
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
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
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
                  backgroundColor: Colors.blue,
                  // linearGradientBackgroundColor: const LinearGradient(
                  //   colors: [Colors.blue, Colors.purple],
                  // ),
                  lineHeight: 10.0,
                  percent: percent,
                  progressColor: Colors.white,
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
}

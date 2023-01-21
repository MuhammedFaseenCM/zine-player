import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zineplayer/AccessFolders/access_videos.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/welcome_2.dart';
import 'package:zineplayer/functions/functions.dart';

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
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [bluecolor, purplecolor])),
        child: Column(
          children: [
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    launcherIcon,
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
                        color: white,
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold),
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
                      enjoy,
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
                ],
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                    onPressed: () {
                      checkSplashFetch(context);
                    },
                    child: Text(nextText)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  checkSplashFetch(BuildContext context) async {
     await splashFetch();
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(createRoute(
      const WelcomeTwo(),
    ));

    final sharefPrefs = await SharedPreferences.getInstance();
    await sharefPrefs.setBool(keyValue, true);
  }
}

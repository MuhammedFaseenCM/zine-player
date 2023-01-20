import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/welcome.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/welcome_3.dart';
import 'package:zineplayer/functions/functions.dart';

class WelcomeTwo extends StatelessWidget {
  const WelcomeTwo({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [bluecolor, purplecolor])),
        child: Column(
          children: [
            const SizedBox(
              height: 160.0,
            ),
            Transform.rotate(
              angle: 320.0,
              child: Image.asset(frameColor2),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Transform.rotate(
              angle: 320.0,
              child: AnimatedTextKit(animatedTexts: [
                TyperAnimatedText(
                  "You can change the frame colour ",
                  speed: const Duration(milliseconds: 50),
                  textAlign: TextAlign.center,
                  textStyle: TextStyle(
                    color: white,
                    fontSize: 23.0,
                  ),
                )
              ]),
            ),
            const SizedBox(
              height: 50.0,
            ),
            Transform.rotate(
              angle: 320.0,
              child: Image.asset(frameColor),
            ),
            Expanded(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(backRoute(const Welcome()));
                          },
                          child: Text(backText)),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        //  margin: const EdgeInsets.only(left: 20.0, top: 100.0),
                        child: ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pushReplacement(
                                  createRoute(const WelcomeThree()));
                            },
                            child: Text(nextText))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

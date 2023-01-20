import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/main_screen.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/welcome_3.dart';
import 'package:zineplayer/functions/functions.dart';

class WelcomeFour extends StatefulWidget {
  const WelcomeFour({super.key});

  @override
  State<WelcomeFour> createState() => _WelcomeFourState();
}

class _WelcomeFourState extends State<WelcomeFour> {
  bool isloading = false;
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
              height: 260.0,
            ),
            Transform.rotate(
              angle: 320.0,
              child: Image.asset(resumePic),
            ),
            const SizedBox(
              height: 30.0,
            ),
            SizedBox(
              height: 80.0,
              child: Transform.rotate(
                angle: 320.0,
                child: AnimatedTextKit(animatedTexts: [
                  TyperAnimatedText(
                    "You can continue video from where\nyou stopped ",
                    speed: const Duration(milliseconds: 50),
                    textAlign: TextAlign.center,
                    textStyle: TextStyle(
                      color: white,
                      fontSize: 23.0,
                    ),
                  )
                ]),
              ),
            ),
            const SizedBox(
              height: 50.0,
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
                            Navigator.of(context).pushReplacement(
                                backRoute(const WelcomeThree()));
                          },
                          child: Text(backText)),
                    ),
                    Align(
                        alignment: Alignment.bottomRight,
                        //  margin: const EdgeInsets.only(left: 20.0, top: 100.0),
                        child: isloading
                            ? const CircularProgressIndicator()
                            : ElevatedButton(
                                onPressed: () {
                                  gotoMain(context);
                                },
                                child: Text(go))),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  gotoMain(BuildContext context) async {
    setState(() {
      isloading = true;
    });
    await Future.delayed(const Duration(seconds: 4));
    // ignore: use_build_context_synchronously
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (ctx) => const MainScreen()));
  }
}

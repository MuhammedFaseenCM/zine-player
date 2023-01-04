import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';



  rotate(isportrait) async {
    if (isportrait) {
      AutoOrientation.landscapeRightMode();
    } else {
      AutoOrientation.portraitUpMode();
    }
  }

    void setLandscape() async {
    await SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);

     await Wakelock.enable();
  }

  void setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    // await Wakelock.disable();
  }

    playFunction({required controller,required setState}) {
    if (controller.value.isPlaying) {
      setState(() {
        controller.pause();
      });
    } else {
      setState(() {
        controller.play();
      });
    }
  }
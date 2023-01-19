import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';

rotate(isportrait) async {
  if (isportrait) {
    AutoOrientation.landscapeRightMode();
  } else {
    AutoOrientation.portraitUpMode();
  }
}

void setLandscape(context, widget, controller, videoPath) async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
  await Wakelock.enable();

  widget.duration != 0 ? resumeStartDailog(context, controller, widget) : null;
}

void setAllOrientations() async {
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
}

void resumeStartDailog(BuildContext context, controller, widget) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title:  Text(continueText),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child:  Text(startoverText)),
        TextButton(
            onPressed: () {
              controller.seekTo(Duration(seconds: widget.duration));
              Navigator.of(context).pop();
            },
            child:  Text(resumeText)),
      ],
    ),
  );
}

import 'dart:developer';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'package:wakelock/wakelock.dart';

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

  widget.duration != 0 ? newPlayListDialog(context, controller, widget) : null;
}

void setAllOrientations() async {
  await SystemChrome.setPreferredOrientations(DeviceOrientation.values);
  // await Wakelock.disable();
}

void newPlayListDialog(BuildContext context, controller, widget) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text("Continue from where you stopped ?"),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Start over")),
        TextButton(
            onPressed: () {
              controller.seekTo(Duration(seconds: widget.duration));
              Navigator.of(context).pop();
            },
            child: const Text("Resume")),
      ],
    ),
  );
}

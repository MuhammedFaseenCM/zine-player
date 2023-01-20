import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';

Future<String> getthumbnail(path) async {
  return thumbnailFile = (await VideoThumbnail.thumbnailFile(
      video: path,
      thumbnailPath: (await getTemporaryDirectory()).path,
      imageFormat: ImageFormat.PNG))!;
}

Widget thumbnail({duration, required path}) {
  return Stack(
    children: [
      Container(
          height: 50.0,
          width: 90.0,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: black,
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(5.0),
                bottomRight: Radius.circular(5.0),
                topLeft: Radius.circular(5.0),
                topRight: Radius.circular(5.0)),
          ),
          child: FutureBuilder(
            future: getthumbnail(path),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                String data = snapshot.data!;
                return Image.file(File(data));
              } else {
                return Image.asset(
                  launcherIcon,
                  width: 50,
                );
              }
            },
          )),
      Positioned(
          right: 0.0,
          bottom: 0.0,
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: [bluecolor, purplecolor])),
            child: duration != null
                ? Text(
                    duration.toString().split("0:0").last,
                    style: TextStyle(color: white, fontSize: 11.0),
                  )
                : null,
          ))
    ],
  );
}

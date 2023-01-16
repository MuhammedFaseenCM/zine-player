import 'dart:io';

import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen_widget.dart';
import 'package:zineplayer/functions/functions.dart';

class PipScreen extends StatefulWidget {
  final String videoPath;
  const PipScreen({super.key, required this.videoPath});

  @override
  State<PipScreen> createState() => _PipScreenState();
}

class _PipScreenState extends State<PipScreen> {
  bool isvisible = true;
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.file(File(widget.videoPath));
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    setState(() {
      isPIPVisible = true;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: isPIPVisible,
      child: Positioned(
          bottom: 6,
          left: 5,
          child: Container(
            clipBehavior: Clip.hardEdge,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10.0),
                  bottomRight: Radius.circular(10.0),
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)),
            ),
            width: 180,
            height: 100,
            child: Stack(
              children: [
                VideoPlayer(_controller),
                Center(
                  child: IconButton(
                    onPressed: () {
                      _controller.value.isPlaying
                          ? _controller.pause()
                          : _controller.play();
                    },
                    icon: playpause(_controller),
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            isPIPVisible = false;
                          });
                        },
                        icon: Icon(
                          Icons.close,
                          color: white,
                        ))),
                Positioned(
                    top: 0,
                    left: 0,
                    child: IconButton(
                        onPressed: () {
                          playVideo(
                              videotitle: widget.videoPath,
                              context: context,
                              videoPath: widget.videoPath,
                              splittedvideotitle: widget.videoPath,
                              durationinSec:
                                  _controller.value.position.inSeconds);
                          _controller.pause();
                          Navigator.of(context).pop();
                        },
                        icon: Icon(
                          Icons.fit_screen_sharp,
                          color: white,
                        ))),
              ],
            ),
          )),
    );
  }
}

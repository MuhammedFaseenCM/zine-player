import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen_functions.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/PlayScreenWidget.dart';

class PlayScreen extends StatefulWidget {
  final String videoFile;
  final String videotitle;

  const PlayScreen(
      {super.key, required this.videoFile, required this.videotitle});
  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;
  String currentDuration = '0';
  static const allspeeds = <double>[0.25, 0.5, 1.0, 1.5, 2.0, 3.0, 4.0, 5.0];

  @override
  void initState() {
    Wakelock.enable();
    super.initState();
    Wakelock.enable();
    _controller = VideoPlayerController.file(File(widget.videoFile));

    _controller.addListener(() {
      setState(() {
        currentDuration = _controller.value.position.toString();
      });
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    setLandscape();
    // invisibilityTime();
    screenVisibility();
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllOrientations();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    DeviceOrientation.landscapeLeft;
    currentDuration = _controller.value.position.toString();
    addToRecentList(
        title: widget.videotitle,
        context: context,
        videoPath: widget.videoFile,
        recentduration: currentDuration);
    Wakelock.disable();
  }

  bool isShow = true;
  bool isLocked = false;
  bool isLockButton = true;
  String leftText = '';
  String rightText = '';
  String playPauseText = '';
  List<BoxFit> Fit = [
    BoxFit.cover,
    BoxFit.fitWidth,
    BoxFit.fitHeight,
  ];
  int _index = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: OrientationBuilder(
        builder: (context, orientation) {
          final isPortrait = orientation == Orientation.portrait;
          return GestureDetector(
            onTap: () => screenVisibility(),
            onDoubleTap: () {
              isLocked == false
                  ? playFunction(controller: _controller, setState: setState)
                  : null;
            },
            child: Stack(children: <Widget>[
              videoContent(fit: Fit, controller: _controller, index: _index),
              topBar(
                  isPortrait: isPortrait,
                  top: 0.0,
                  context: context,
                  isShow: isShow,
                  widget: widget,
                  controller: _controller,
                  setState: setState),
              bottomBar(330.0, orientation),
              indicatorNduration(
                  orientation: orientation,
                  controller: _controller,
                  isShow: isShow,
                  lefttext: currentDuration.toString().split('.').first,
                  righttext:
                      _controller.value.duration.toString().split('.').first,
                  currentDuration: currentDuration),
              lockButton(
                orientation,
              ),
              leftseekContainer(
                  left: 0.0,
                  seconds: -10,
                  text: "-10 seconds",
                  orientation: orientation),
              rightseekContainer(
                  left: 550.0,
                  seconds: 10,
                  text: "+10 seconds",
                  orientation: orientation)
            ]),
          );
        },
      ),
    );
  }

  Widget rightseekContainer(
          {required double left,
          required seconds,
          required text,
          required orientation}) =>
      GestureDetector(
        onLongPressMoveUpdate: (details) {},
        child: Container(
          margin: orientation == Orientation.landscape
              ? EdgeInsets.only(top: 60.0, left: left)
              : const EdgeInsets.only(top: 100.0, left: 260.0),
          width: orientation == Orientation.landscape ? 320.0 : 150.0,
          height: orientation == Orientation.landscape ? 270.0 : 650.0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => screenVisibility(),
            onDoubleTap: () {
              _controller.seekTo(
                  _controller.value.position + Duration(seconds: seconds));
              setState(() {
                leftText = text;
              });
              Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                  leftText = '';
                }),
              );
            },
            child: Center(
              child: Text(
                leftText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );

  Widget leftseekContainer(
          {required double left,
          required seconds,
          required text,
          required orientation}) =>
      GestureDetector(
        onLongPressMoveUpdate: (details) {},
        child: Container(
          margin: orientation == Orientation.landscape
              ? EdgeInsets.only(top: 60.0, left: left)
              : const EdgeInsets.only(top: 100.0),
          width: orientation == Orientation.landscape ? 320.0 : 150.0,
          height: orientation == Orientation.landscape ? 270.0 : 650.0,
          color: Colors.transparent,
          child: InkWell(
            onTap: () => screenVisibility(),
            onDoubleTap: () {
              _controller.seekTo(
                  _controller.value.position + Duration(seconds: seconds));
              setState(() {
                rightText = text;
              });
              Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                  rightText = '';
                }),
              );
            },
            child: Center(
              child: Text(
                rightText,
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      );

  Widget bottomBar(top, orientation) => Visibility(
        visible: isShow,
        child: Container(
          margin: orientation == Orientation.landscape
              ? EdgeInsets.only(top: top, bottom: 0.0)
              : const EdgeInsets.only(top: 800.0, bottom: 0.0),
          width: double.infinity,
          height: 100,
          color: const Color.fromARGB(113, 158, 158, 158),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                      onPressed: () {
                        _controller.seekTo(_controller.value.position -
                            const Duration(seconds: 10));
                      },
                      icon: const Icon(
                        Icons.fast_rewind,
                        color: Colors.white,
                        size: 40.0,
                      )),
                  IconButton(
                      onPressed: () {
                        playFunction(
                            controller: _controller, setState: setState);
                      },
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.white,
                        size: 40.0,
                      )),
                  IconButton(
                    icon: const Icon(
                      Icons.fast_forward,
                      size: 40.0,
                    ),
                    onPressed: () {
                      _controller.seekTo(_controller.value.position +
                          const Duration(seconds: 10));
                    },
                    color: Colors.white,
                  )
                ],
              ),
              IconButton(
                  onPressed: () {
                    setState(() {
                      _index = (_index + 1) % Fit.length;
                    });
                  },
                  color: Colors.white,
                  icon: const Icon(Icons.tv))
            ],
          ),
        ),
      );

  screenVisibility() async {
    setState(() {
      if (isLocked == true) {
        isShow = false;
      } else {
        isShow = !isShow;
      }
      if (isShow == true) {
        isLockButton = true;
      } else {
        isLockButton = !isLockButton;
      }
    });
    if (isShow == true) {
      await Future.delayed(const Duration(seconds: 5));
      isShow = false;
      isLockButton = false;
    }
  }

  Widget lockButton(
    Orientation orientation,
  ) =>
      Container(
        color: isLocked
            ? const Color.fromARGB(113, 158, 158, 158)
            : Colors.transparent,
        margin: orientation == Orientation.landscape
            ? const EdgeInsets.only(top: 350.0)
            : const EdgeInsets.only(top: 820.0),
        child: Visibility(
          visible: isLockButton,
          child: IconButton(
            onPressed: () {
              setState(() {
                isLocked = !isLocked;
                if (isLocked == false) {
                  isShow = true;
                } else {
                  isShow = false;
                }
              });
            },
            icon: const Icon(Icons.lock),
            color: Colors.white,
          ),
        ),
      );
}

import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen_functions.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen_widget.dart';

class PlayScreen extends StatefulWidget {
  final String videoFile;
  final String videotitle;
  int duration;

  PlayScreen(
      {super.key,
      required this.videoFile,
      required this.videotitle,
      required this.duration});
  @override
  PlayScreenState createState() => PlayScreenState();
}

class PlayScreenState extends State<PlayScreen> {
  late VideoPlayerController _controller;
  String currentDuration = '0';

  Duration resumeDuration = const Duration();

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile));

    _controller.addListener(() {
      setState(() {
        currentDuration = _controller.value.position.toString();
      });
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));

    log("${widget.duration}");
    _controller.play();
    setLandscape(context, widget, _controller, widget.videoFile);
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
    resumeDuration = _controller.value.position;
    widget.duration = _controller.value.position.inSeconds;
    addToRecentList(
        title: widget.videotitle,
        context: context,
        videoPath: widget.videoFile,
        recentduration: currentDuration,
        durationinSec: widget.duration);
    Wakelock.disable();
  }

  bool isShow = true;
  bool isLocked = false;
  bool isLockButton = true;
  bool isLeftIconVisible = false;
  bool isrRightIconVisible = false;
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
            onPanUpdate: (details) {
              if (details.delta.dy < 0) {
                setState(() {
                  _controller.setVolume(vol);
                });
              } else if (details.delta.dx > 0) {
                isLocked == false
                    ? _controller.seekTo(
                        _controller.value.position + const Duration(seconds: 5))
                    : null;
              } else if (details.delta.dx < 0) {
                isLocked == false
                    ? _controller.seekTo(
                        _controller.value.position - const Duration(seconds: 5))
                    : null;
              }
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
              bottomBar(350.0, orientation),
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
                  text: "-10s",
                  orientation: orientation),
              rightseekContainer(
                  left: 550.0,
                  seconds: 10,
                  text: "+10s",
                  orientation: orientation),
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
              isLocked == false
                  ? _controller.seekTo(
                      _controller.value.position + Duration(seconds: seconds))
                  : null;
              setState(() {
                isLocked == false ? leftText = text : null;
                isLocked == false ? isrRightIconVisible = true : null;
              });
              Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                  leftText = '';
                  isrRightIconVisible = false;
                }),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: isrRightIconVisible
                            ? const Icon(
                                Icons.fast_forward,
                                size: 30.0,
                                color: Colors.white,
                              )
                            : null),
                    Center(
                      child: Text(
                        leftText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                    ),
                  ],
                ),
                Center(child: brightnessSlider()),
              ],
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
        child: Container(
          margin: orientation == Orientation.landscape
              ? EdgeInsets.only(top: 60.0, left: left)
              : const EdgeInsets.only(top: 100.0),
          width: orientation == Orientation.landscape ? 320.0 : 200.0,
          height: orientation == Orientation.landscape ? 270.0 : 650.0,
          color: const Color.fromARGB(0, 200, 230, 201),
          child: InkWell(
            onTap: () => screenVisibility(),
            onDoubleTap: () {
              isLocked == false
                  ? _controller.seekTo(
                      _controller.value.position + Duration(seconds: seconds))
                  : null;
              setState(() {
                isLocked == false ? rightText = text : null;
                isLocked == false ? isLeftIconVisible = true : null;
              });

              Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                  rightText = '';
                  isLeftIconVisible = false;
                }),
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Center(child: volumeSlider()),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Center(
                        child: isLeftIconVisible
                            ? const Icon(
                                Icons.fast_rewind,
                                size: 30.0,
                                color: Colors.white,
                              )
                            : null),
                    Center(
                      child: Text(
                        rightText,
                        style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 30.0),
                      ),
                    ),
                  ],
                ),
              ],
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
          color: const Color.fromARGB(132, 158, 158, 158),
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
            ? const EdgeInsets.only(top: 370.0, left: 3.0)
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
            icon:
                isLocked ? const Icon(Icons.lock) : const Icon(Icons.lock_open),
            color: Colors.white,
          ),
        ),
      );
  double val = 0.5;
  Widget brightnessSlider() => Visibility(
        visible: isShow,
        child: SliderTheme(
            data: const SliderThemeData(
              thumbColor: Colors.white,
              trackHeight: 1.0,
            ),
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: SfSlider.vertical(
                        inactiveColor: Colors.white,
                        activeColor: Colors.blue,
                        min: 0.0,
                        max: 1.0,
                        value: val,
                        onChanged: (value) {
                          setState(() {
                            val = value;
                            FlutterScreenWake.setBrightness(val);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                val == 0.0
                    ? const Icon(Icons.brightness_low, color: Colors.white)
                    : const Icon(Icons.brightness_high, color: Colors.white),
              ],
            )),
      );
  double vol = 0.5;
  Widget volumeSlider() => Visibility(
        visible: isShow,
        child: SliderTheme(
            data: const SliderThemeData(
              thumbColor: Colors.white,
              trackHeight: 1.0,
              overlayShape: RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Column(
              children: [
                //const Icon(Icons.volume_up, color: Colors.white),
                Row(
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: SfSlider.vertical(
                        inactiveColor: Colors.white,
                        activeColor: Colors.blue,
                        min: 0.0,
                        max: 1.0,
                        value: vol,
                        onChanged: (value) {
                          setState(() {
                            vol = value;
                            _controller.setVolume(vol);
                          });
                        },
                      ),
                    ),
                  ],
                ),
                vol != 0.0
                    ? const Icon(Icons.volume_up, color: Colors.white)
                    : const Icon(Icons.volume_off, color: Colors.white)
              ],
            )),
      );
}
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screen_wake/flutter_screen_wake.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20functions/list_functions.dart';
import 'package:zineplayer/Home/Screen%20functions/play_screen_functions.dart';
import 'package:zineplayer/Home/Screen%20widgets/play_screen_widget.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/functions/datamodels.dart';

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
  int _index = 0;
  Color color = defaultColor;
  late String barColor;
  @override
  void initState() {
    barcolorFunction();
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoFile));
    _controller.addListener(() {
      setState(() {
        currentDuration = _controller.value.position.toString();
      });
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();
    setLandscape(context, widget, _controller, widget.videoFile);
    screenVisibility();
  }

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
              isLocked ? null : playFunction();
            },
            onPanUpdate: (details) {
              swipeFunction(details);
            },
            child: Stack(children: <Widget>[
              videoContent(fit: fit, controller: _controller, index: _index),
              durationSwipe(),
              Center(child: playPauseBool ? playpause() : null),
              leftseekContainer(orientation: orientation),
              rightseekContainer(orientation: orientation),
              topBar(isPortrait: isPortrait),
              bottomBar(orientation),
              lockButton(orientation),
            ]),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllOrientations();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    DeviceOrientation.landscapeLeft;
    int totalduration = _controller.value.duration.inSeconds;
    widget.duration = _controller.value.position.inSeconds;
    addToRecentList(
        title: widget.videotitle,
        context: context,
        videoPath: widget.videoFile,
        totalduration: totalduration,
        durationinSec: widget.duration);
    Wakelock.disable();
  }

  Widget rightseekContainer({required orientation}) => GestureDetector(
        onLongPressMoveUpdate: (details) {},
        child: Align(
          alignment: Alignment.centerRight,
          child: Container(
            width: MediaQuery.of(context).size.width / 3,
            color: transparent,
            child: InkWell(
              onTap: () => screenVisibility(),
              onDoubleTap: () {
                isLocked ? null : forwardSec(10);
                setState(() {
                  isLocked ? null : leftText = plusten;
                  isLocked ? null : isrRightIconVisible = true;
                });
                Future.delayed(
                  const Duration(milliseconds: 500),
                  () => setState(() {
                    leftText = '';
                    isrRightIconVisible = false;
                  }),
                );
              },
              child: Stack(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isrRightIconVisible
                          ? screenIcon(Icons.fast_forward)
                          : SizedBox(),
                      Center(child: seekText(leftText)),
                    ],
                  ),
                  volumeSlider(orientation),
                ],
              ),
            ),
          ),
        ),
      );
  Widget screenIcon(icon) => Icon(
        icon,
        size: 30.0,
        color: white,
      );
  Widget durationSwipe() => Center(
          child: Text(
        textDur,
        style: TextStyle(fontSize: 30.0, color: white),
      ));
  Widget leftseekContainer({required orientation}) => GestureDetector(
        child: Container(
          width: MediaQuery.of(context).size.width / 3,
          color: transparent,
          child: InkWell(
            onTap: () => screenVisibility(),
            onDoubleTap: () {
              isLocked ? null : rewindSec(10);
              setState(() {
                isLocked ? null : rightText = minusten;
                isLocked ? null : isLeftIconVisible = true;
              });

              Future.delayed(
                const Duration(milliseconds: 500),
                () => setState(() {
                  rightText = '';
                  isLeftIconVisible = false;
                }),
              );
            },
            child: Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    isLeftIconVisible
                        ? screenIcon(Icons.fast_rewind)
                        : SizedBox(),
                    Center(child: seekText(rightText)),
                  ],
                ),
                brightnessSlider(orientation),
              ],
            ),
          ),
        ),
      );
  Widget seekText(text) => Text(
        text,
        style: TextStyle(
            color: white, fontWeight: FontWeight.bold, fontSize: 20.0),
      );
  playFunction() {
    _controller.value.isPlaying
        ? setState(() {
            _controller.pause();
            playPauseBool = true;
            Future.delayed(
                const Duration(milliseconds: 500), () => playPauseBool = false);
          })
        : setState(() {
            _controller.play();
            playPauseBool = true;
            Future.delayed(
                const Duration(milliseconds: 500), () => playPauseBool = false);
          });
  }

  Widget bottomBar(orientation) => Visibility(
        visible: isShow,
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: 70,
            color: color,
            child: Column(
              children: [
                indicatorNduration(orientation: orientation),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(
                      width: 110.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                            onPressed: () {
                              rewindSec(10);
                            },
                            icon: Icon(
                              Icons.fast_rewind,
                              color: white,
                              size: 40.0,
                            )),
                        IconButton(
                            onPressed: () {
                              playFunction();
                            },
                            icon: playpause()),
                        IconButton(
                          icon: const Icon(
                            Icons.fast_forward,
                            size: 40.0,
                          ),
                          onPressed: () {
                            forwardSec(10);
                          },
                          color: white,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 50.0,
                        ),
                        IconButton(
                            onPressed: () {
                              setState(() {
                                _index = (_index + 1) % fit.length;
                              });
                            },
                            color: white,
                            icon: const Icon(Icons.fit_screen)),
                        const SizedBox(
                          width: 50.0,
                        )
                        // IconButton(
                        //     onPressed: () {
                        //       // Navigator.of(context).push(
                        //       //       PipScreen(videoPath: widget.videoFile),
                        //       // ));
                        //     },
                        //     color: white,
                        //     icon: const Icon(Icons.picture_in_picture_alt)),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      );

  screenVisibility() async {
    setState(() {
      isLocked ? isShow = false : isShow = !isShow;

      isShow ? isLockButton = true : isLockButton = !isLockButton;
    });
    if (isShow == true) {
      await Future.delayed(const Duration(seconds: 5));
      isShow = false;
      isLockButton = false;
    }
  }

  Widget playpause() => Icon(
        _controller.value.isPlaying ? Icons.play_arrow : Icons.pause,
        color: white,
        size: 40.0,
      );

  Widget lockButton(
    Orientation orientation,
  ) =>
      Align(
        alignment: Alignment.bottomLeft,
        child: Container(
          color: isLocked ? color : transparent,
          child: Visibility(
            visible: isLockButton,
            child: IconButton(
              onPressed: () {
                setState(() {
                  isLocked = !isLocked;
                  isLocked ? isShow = false : isShow = true;
                });
              },
              icon: isLocked
                  ? const Icon(Icons.lock)
                  : const Icon(Icons.lock_open),
              color: white,
            ),
          ),
        ),
      );
  double val = 0.5;
  Widget brightnessSlider(orientation) => Visibility(
        visible: isShow,
        child: SliderTheme(
            data: SliderThemeData(
              thumbColor: white,
              trackHeight: 1.0,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: orientation == Orientation.portrait
                      ? MediaQuery.of(context).size.height / 2.8
                      : MediaQuery.of(context).size.height / 4,
                ),
                Column(
                  children: [
                    SizedBox(
                      width: 100.0,
                      child: SfSlider.vertical(
                        inactiveColor: white,
                        activeColor: bluecolor,
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
                    ? Icon(Icons.brightness_low, color: white)
                    : Icon(Icons.brightness_high, color: white),
              ],
            )),
      );

  double vol = 0.5;
  Widget volumeSlider(orientation) => Visibility(
        visible: isShow,
        child: SliderTheme(
            data: SliderThemeData(
              thumbColor: white,
              trackHeight: 1.0,
              overlayShape: const RoundSliderOverlayShape(overlayRadius: 20.0),
            ),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerRight,
                  child: SizedBox(
                    height: orientation == Orientation.portrait
                        ? MediaQuery.of(context).size.height / 2.8
                        : MediaQuery.of(context).size.height / 4,
                  ),
                ),
                Stack(
                  children: [
                    SizedBox(
                      width: 150.0,
                      child: SfSlider.vertical(
                        inactiveColor: white,
                        activeColor: bluecolor,
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
                    ? Icon(Icons.volume_up, color: white)
                    : Icon(Icons.volume_off, color: white)
              ],
            )),
      );

  swipeFunction(details) {
    if (details.delta.dy > 0 || details.delta.dy < 0) {
      return;
    } else if (details.delta.dx > 0) {
      isLocked ? null : forwardSec(5);
      setState(() {
        isLocked ? null : textDur = "[${currentDuration.split(".").first}]";
        Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() {
            textDur = '';
          }),
        );
      });
    } else if (details.delta.dx < 0) {
      isLocked ? null : rewindSec(5);
      setState(() {
        isLocked ? null : textDur = "[${currentDuration.split(".").first}]";
        Future.delayed(
          const Duration(milliseconds: 500),
          () => setState(() {
            textDur = '';
          }),
        );
      });
    }
  }

  Widget topBar({
    required isPortrait,
  }) =>
      Visibility(
        visible: isShow,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 60,
          color: color,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Wakelock.disable();
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: white,
                  )),
              Text(
                widget.videotitle,
                style: TextStyle(color: white),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.screen_rotation),
                    onPressed: () {
                      rotate(isPortrait);
                    },
                    color: white,
                  ),
                  playSpeed(controller: _controller, setState: setState),
                ],
              )
            ],
          ),
        ),
      );
  Widget indicatorNduration({required orientation}) => Row(
        //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            width: 5.0,
          ),
          duration(currentDuration.split('.').first,
              isShow: isShow,
              text: currentDuration.toString().split('.').first),
          SizedBox(
            width: 5.0,
          ),
          Expanded(child: indicator(controller: _controller, isShow: isShow)),
          SizedBox(
            width: 5.0,
          ),
          duration(_controller.value.duration.toString().split('.').first,
              isShow: isShow,
              text: _controller.value.duration.toString().split('.').first),
          SizedBox(
            width: 5.0,
          ),
        ],
      );
  forwardSec(sec) {
    _controller.seekTo(_controller.value.position + Duration(seconds: sec));
  }

  rewindSec(sec) {
    _controller.seekTo(_controller.value.position - Duration(seconds: sec));
  }

  barcolorFunction() async {
    final colorhive = await Hive.openBox<FrameColor>('colorBox');
    FrameColor? bar = colorhive.getAt(0);

    barColor = bar!.color.toString();
    int colorInt = int.parse(
        barColor.substring(barColor.indexOf("(") + 1, barColor.indexOf(")")));
    setState(() {
      color = Color(colorInt);
    });
  }
}

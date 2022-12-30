import 'dart:io';

import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class VideoScreen extends StatefulWidget {
  var videoFile;
  String videotitle;
  VideoScreen({super.key, required this.videoFile, required this.videotitle});

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: _ButterFlyAssetVideo(
          videoFile: widget.videoFile, videotitle: widget.videotitle),
    );
  }
}

class _ButterFlyAssetVideo extends StatefulWidget {
  var videoFile;
  String videotitle;
  _ButterFlyAssetVideo({required this.videoFile, required this.videotitle});
  @override
  _ButterFlyAssetVideoState createState() => _ButterFlyAssetVideoState();
}

class _ButterFlyAssetVideoState extends State<_ButterFlyAssetVideo> {
  late VideoPlayerController _controller;
  String currentDuration = '0';

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.file(widget.videoFile);

    _controller.addListener(() {
      setState(() {
        currentDuration = _controller.value.position.toString();
      });
    });
    _controller.setLooping(true);
    _controller.initialize().then((_) => setState(() {}));
    _controller.play();

    setLandscape();
  }

  @override
  void dispose() {
    _controller.dispose();
    setAllOrientations();
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    DeviceOrientation.landscapeLeft;
  }

  bool isShow = true;
  bool isLocked = false;
  bool isLockButton = false;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        final isPortrait = orientation == Orientation.portrait;
        return InkWell(
          onTap: () => screenVisibility(),
          onDoubleTap: () {
            playFunction();
          },
          child: Stack(children: <Widget>[
            VideoContent(),
            topBar(isPortrait, 0.0),
            BottomBar(350.0),
            indicatorNduration(),
            lockButton()
          ]),
        );
      },
    );
  }

  // DeviceOrientation isPortrait = DeviceOrientation.portraitDown;
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

    // await Wakelock.enable();
  }

  void setAllOrientations() async {
    await SystemChrome.setPreferredOrientations(DeviceOrientation.values);

    // await Wakelock.disable();
  }

  Widget VideoContent() {
    return SizedBox.expand(
        child: FittedBox(
            fit: BoxFit.cover,
            child: SizedBox(
              width: _controller.value.size.width,
              height: _controller.value.size.height,
              child: VideoPlayer(_controller),
            )));
  }

  Widget topBar(isPortrait, top) {
    return Visibility(
      visible: isShow,
      child: Container(
        margin: EdgeInsets.only(top: top),
        width: double.infinity,
        height: 60,
        color: Color.fromARGB(113, 158, 158, 158),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text(
              widget.videotitle,
              style: TextStyle(color: Colors.white),
            ),
            IconButton(
              icon: const Icon(Icons.rotate_left_sharp),
              onPressed: () {
                rotate(isPortrait);
              },
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget BottomBar(top) {
    return Visibility(
      visible: isShow,
      child: Container(
        margin: EdgeInsets.only(top: top, bottom: 0.0),
        width: double.infinity,
        height: 60,
        color: Color.fromARGB(113, 158, 158, 158),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {
                  _controller.seekTo(
                      _controller.value.position - const Duration(seconds: 10));
                },
                icon: const Icon(
                  Icons.fast_rewind,
                  color: Colors.white,
                  size: 40.0,
                )),
            IconButton(
                onPressed: () {
                  playFunction();
                },
                icon: Icon(
                  _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                  color: Colors.white,
                  size: 40.0,
                )),
            IconButton(
              icon: const Icon(
                Icons.fast_forward,
                size: 40.0,
              ),
              onPressed: () {
                _controller
                    .seekTo(_controller.value.position + Duration(seconds: 10));
              },
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget indicatorNduration() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        currentDurationFunction(),
        Container(
            width: 750.0,
            margin: EdgeInsets.only(top: 350.0),
            child: Indicator()),
        duration()
      ],
    );
  }

  Widget lockButton() {
    return Container(
      margin: EdgeInsets.only(top: 350.0),
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
          icon: Icon(Icons.lock),
          color: Colors.white,
        ),
      ),
    );
  }

  playFunction() {
    if (_controller.value.isPlaying) {
      setState(() {
        _controller.pause();
      });
    } else {
      setState(() {
        _controller.play();
      });
    }
  }

  screenVisibility() {
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
  }

  Widget Indicator() => Visibility(
      visible: isShow,
      child: VideoProgressIndicator(
        _controller,
        allowScrubbing: true,
        colors: const VideoProgressColors(playedColor: Colors.purple),
      ));

  Widget duration() => Visibility(
      visible: isShow,
      child: Text(
        _controller.value.duration.toString().split('.').first,
        style: TextStyle(color: Colors.white),
      ));

  Widget currentDurationFunction() => Visibility(
        visible: isShow,
        child: Text(
          // _controller.value.duration.toString().split('.').first,
          currentDuration.split('.').first,
          style: TextStyle(color: Colors.white),
        ),
      );
}

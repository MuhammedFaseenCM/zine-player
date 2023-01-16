import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/play_screen_functions.dart';
import 'package:zineplayer/Home/Screens/PlayScreen/video_progress_indicator.dart';

Widget videoContent({required fit, required index, required controller}) =>
    SizedBox.expand(
      child: FittedBox(
        fit: fit[index],
        child: SizedBox(
          width: controller.value.size.width,
          height: controller.value.size.height,
          child: VideoPlayer(controller),
        ),
      ),
    );

Widget topBar(
        {required isPortrait,
        required top,
        required isShow,
        required context,
        required widget,
        required setState,
        required controller}) =>
    Visibility(
      visible: isShow,
      child: Container(
        margin: EdgeInsets.only(top: top),
        width: double.infinity,
        height: 60,
        color: const Color.fromARGB(132, 158, 158, 158),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Wakelock.disable();
                },
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                )),
            Text(
              widget.videotitle,
              style: const TextStyle(color: Colors.white),
            ),
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.screen_rotation),
                  onPressed: () {
                    rotate(isPortrait);
                  },
                  color: Colors.white,
                ),
                playSpeed(controller: controller, setState: setState),
              ],
            )
          ],
        ),
      ),
    );
double _playbackSpeed = 1.0;
Widget playSpeed({required controller, required setState}) =>
    PopupMenuButton<double>(
        icon: const Icon(
          Icons.speed,
          color: Colors.white,
        ),
        color: Colors.white,
        initialValue: controller.value.playbackSpeed,
        tooltip: 'Playback speed',
        onSelected: (value) {
          _playbackSpeed = value;
          controller.setPlaybackSpeed(value);
        },
        itemBuilder: (context) => [
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 0.5;
                    controller.setPlaybackSpeed(0.5);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("0.5x")),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 1.0;
                    controller.setPlaybackSpeed(1.0);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("1.0x")),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 1.5;
                    controller.setPlaybackSpeed(1.5);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("1.5x")),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 2.0;
                    controller.setPlaybackSpeed(2.0);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("2.0x")),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 2.5;
                    controller.setPlaybackSpeed(2.5);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("2.5x")),
              ),
              PopupMenuItem(
                onTap: () {
                  setState(() {
                    _playbackSpeed = 3.0;
                    controller.setPlaybackSpeed(3.0);
                  });
                },
                height: 30.0,
                child: const Center(child: Text("3.0x")),
              )
            ]);
popupMenuItem({required setState, required controller, required value}) =>
    PopupMenuItem(
      child: RadioListTile(
        value: 0.5,
        groupValue: _playbackSpeed,
        onChanged: (value) {
          setState(() {
            _playbackSpeed = value!;
            controller.setPlaybackSpeed(value);
          });
        },
        title: Text('$value x'),
      ),
    );
Widget playpause(controller) => Icon(
        controller.value.isPlaying ? Icons.play_arrow : Icons.pause,
        color: white,
        size: 40.0,
      );
Widget indicator({required isShow, required controller}) => Visibility(
    visible: isShow,
    child: CustomProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: const VideoProgressColors(
          playedColor: Colors.blue, backgroundColor: Colors.white),
    ));

Widget duration(first, {required text, required isShow}) => Visibility(
    visible: isShow,
    child: Container(
      margin: const EdgeInsets.only(top: 350.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ));

import 'package:color_picker_field/color_picker_field.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_sliders/sliders.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
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
                // IconButton(
                //   onPressed: () {},
                //   icon: Icon(Icons.subtitles),
                //   color: Colors.white,
                // ),

                IconButton(
                  icon: const Icon(Icons.screen_rotation),
                  onPressed: () {
                    rotate(isPortrait);
                  },
                  color: Colors.white,
                ),
                playSpeed(controller: controller, setState: setState),
                // IconButton(
                //   onPressed: () {
                //     colorDailog(context, pickedColor, pickColor);
                //   },
                //   icon: const Icon(Icons.color_lens),
                //   color: Colors.white,
                // )
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
              //  PopupMenuItem(height: 10.0, child: SizedBox()),
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
              //  PopupMenuItem(height: 10.0, child: SizedBox()),
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
              //  PopupMenuItem(height: 10.0, child: SizedBox()),
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
              //   PopupMenuItem(height: 10.0, child: SizedBox()),
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
              // PopupMenuItem(height: 10.0, child: SizedBox()),
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
              // PopupMenuItem(height: 10.0, child: SizedBox()),
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
Widget indicatorNduration(
        {required orientation,
        required controller,
        required isShow,
        required lefttext,
        required righttext,
        required currentDuration}) =>
    Container(
      margin: orientation == Orientation.landscape
          ? const EdgeInsets.only(top: 0.0)
          : const EdgeInsets.only(top: 470.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          duration(currentDuration.split('.').first,
              isShow: isShow, text: lefttext),
          // SizedBox(
          //   width: orientation == Orientation.landscape ? 10.0 : 30.0,
          // ),
          Container(
              width: orientation == Orientation.landscape ? 750.0 : 200.0,
              margin: const EdgeInsets.only(top: 350.0),
              child: indicator(controller: controller, isShow: isShow)),
          // SizedBox(
          //   width: orientation == Orientation.landscape ? 10.0 : 30.0,
          // ),
          duration(controller.value.duration.toString().split('.').first,
              isShow: isShow, text: righttext)
        ],
      ),
    );
Widget indicator({required isShow, required controller}) => Visibility(
    visible: isShow,
    child: CustomProgressIndicator(
      controller,
      allowScrubbing: true,
      colors: const VideoProgressColors(
          playedColor: Colors.blue, backgroundColor: Colors.white),
    ));
// child: SfSlider(
//     inactiveColor: Colors.white,
//     activeColor: Colors.blue,
//     value: currentposition,
//     stepSize: 1.0,
//     min: 0.0,
//     max: duration,
//     onChanged: (value) {
//       seekFunctionSlider(
//           currentposition: currentposition,
//           controller: controller,
//           value: value,
//           duration: duration);
//     }));

Widget duration(first, {required text, required isShow}) => Visibility(
    visible: isShow,
    child: Container(
      margin: const EdgeInsets.only(top: 350.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.white),
      ),
    ));

void colorDailog(BuildContext context, pickedColor, pickColor) {
  showDialog(
    context: context,
    builder: (context) => SingleChildScrollView(
      child: AlertDialog(
        scrollable: true,
        actions: [
          const Text("Choose a color"),
          ColorPicker(
            currentColor: pickedColor,
            onChange: pickColor,
          ),
          Text('Picked Color : $pickedColor')
        ],
      ),
    ),
  );
}

seekFunctionSlider(
    {required currentposition,
    required controller,
    required value,
    required duration}) {
  if (duration > 3599) {
    if (currentposition < value) {
      controller.seekTo(Duration(seconds: currentposition + 60));
    } else {
      controller.seekTo(Duration(seconds: currentposition - 60));
    }
  } else {
    if (currentposition < value) {
      controller.seekTo(Duration(seconds: currentposition + 1));
    } else {
      controller.seekTo(Duration(seconds: currentposition - 1));
    }
  }
}

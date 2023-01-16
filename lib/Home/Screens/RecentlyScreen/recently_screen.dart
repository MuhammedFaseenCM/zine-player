import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recent_video.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              left: 280.0,
            ),
            child: ElevatedButton.icon(
                onPressed: () {
                  deleteRecentList(context);
                },
                icon: Icon(
                  Icons.cleaning_services_rounded,
                  color: purplecolor,
                ),
                label: Text(
                  clear,
                  style: TextStyle(color: purplecolor),
                ),
                style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(white))),
          ),
          Expanded(
            child: ValueListenableBuilder(
              builder:
                  (BuildContext ctx, List<RecentList> recList, Widget? child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final reversed = recList.reversed;
                      List<RecentList> reversedList = reversed.toList();
                      final listdata = reversedList[index];

                      String title = listdata.videoPath.split("/").last;

                      String splittitle = title;
                      if (splittitle.length > 25) {
                        splittitle = "${splittitle.substring(0, 25)}...";
                      }
                      double percent =
                          (listdata.durationinSec / listdata.duration);

                      return RecentVideo(
                        title: title,
                        path: listdata.videoPath,
                        durinSec: listdata.durationinSec,
                        percent: percent,
                        splittitle: splittitle,
                        duration: listdata.duration,
                        index: index,
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: recList.length);
              },
              valueListenable: recentListNotifier,
            ),
          ),
        ],
      ),
    );
  }
}

String convertSecond(durinsec) {
  double hours = durinsec / 3600;
  String minute = hours.toString().split(".").last;
  String hh = hours.toString().split(".").first;
  String mmmm = "0.$minute";
  double num = double.parse(mmmm);
  double mmm = (num) * 60;
  String mm = mmm.toString().split(".").first;
  mm.length == 1 ? mm = "0$mm" : mm = mm;
  hh.length == 1 ? hh = "0$hh" : hh = hh;
  String ssss = mmm.toString().split(".").last;
  String sss = "0.$ssss";
  double number = double.parse(sss);
  double ss = number * 60;
  int sec = ss.round();
  String second = sec.toString();
  second.length == 1 ? second = "0$second" : second = second;
  String hhmmss;

  hhmmss = "$hh:$mm:$second";
  return hhmmss;
}

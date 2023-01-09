import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class RecentScreen extends StatelessWidget {
  const RecentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        builder: (BuildContext ctx, List<RecentList> recList, Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final listdata = recList[index];

                String title = listdata.videoPath.split("/").last;

                String splittitle = title;
                if (splittitle.length > 25) {
                  splittitle = "${splittitle.substring(0, 25)}...";
                }
                return Card(
                  child: ListTile(
                    onTap: () {
                      playVideo(
                          videotitle: title,
                          context: context,
                          videoPath: listdata.videoPath,
                          splittedvideotitle: splittitle,
                          durationinSec: listdata.durationinSec);
                    },
                    leading: thumbnail(),
                    title: Text(splittitle),
                    subtitle: Text(
                        "Last played : ${listdata.duration.toString().split(".").first}"),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: recList.length);
        },
        valueListenable: recentListNotifier,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          deleteRecentList(context);
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [Icon(Icons.delete), Text("Clear")],
        ),
      ),
    );
  }
}

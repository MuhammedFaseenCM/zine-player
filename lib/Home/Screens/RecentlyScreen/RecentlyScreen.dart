import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
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
                return Card(
                  child: ListTile(
                    leading: thumbnail(),
                    title: Text(listdata.title),
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

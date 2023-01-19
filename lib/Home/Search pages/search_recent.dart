import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screen%20widgets/thumbnail_widget.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/Home/Screens/RecentlyScreen/recently_screen.dart';
import 'package:zineplayer/functions/functions.dart';

class RecentSearch extends SearchDelegate {
  late String file;

  String get fileSize {
    final fileSizeInBytes = File(file).lengthSync();
    return filesizing(fileSizeInBytes);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
        onPressed: () {
          query = "";
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, query);
        },
        icon: const Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: recentListNotifier,
      builder: (BuildContext ctx, dynamic recentList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = recentList[index];
            if (data.videoPath.contains(query)) {
              String splittedTitle = data.videoPath.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              String duration = convertSecond(data.duration);
              file = data.videoPath;
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        playVideo(
                            videotitle: splittedTitle,
                            context: context,
                            videoPath: data.videoPath,
                            splittedvideotitle: trimmedTitle,
                            durationinSec: data.durationinSec);
                      },
                      title: Text(trimmedTitle),
                      trailing: popupMenu(
                          index: index,
                          title: splittedTitle,
                          videoPath: data.videoPath,
                          fileSize: fileSize,
                          duration: duration,
                          context: context),
                      leading:
                          thumbnail(duration: duration, path: data.videoPath)),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: recentList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: recentListNotifier,
      builder: (BuildContext ctx, dynamic recentList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = recentList[index];
            if (data.videoPath.contains(query)) {
              String splittedTitle = data.videoPath.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              String duration = convertSecond(data.duration);
              file = data.videoPath;
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        playVideo(
                            videotitle: splittedTitle,
                            context: context,
                            videoPath: data.videoPath,
                            splittedvideotitle: trimmedTitle,
                            durationinSec: data.durationinSec);
                      },
                      title: Text(trimmedTitle),
                      trailing: popupMenu(
                          index: index,
                          title: splittedTitle,
                          videoPath: data.videoPath,
                          fileSize: fileSize,
                          duration: duration,
                          context: context),
                      leading:
                          thumbnail(duration: duration, path: data.videoPath)),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: recentList.length,
        );
      },
    );
  }
}

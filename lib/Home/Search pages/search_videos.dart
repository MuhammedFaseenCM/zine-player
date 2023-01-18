import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_all_videos.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/video_container.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';
import 'package:zineplayer/main.dart';

class VideoSearch extends SearchDelegate {
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
      valueListenable: allVideos,
      builder: (BuildContext ctx, dynamic videosList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = videosList[index];
            AllVideos? videoinfo = videoDB.getAt(index);
            if (data.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              file = data;
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      playVideo(
                          videotitle: splittedTitle,
                          context: context,
                          videoPath: data,
                          splittedvideotitle: trimmedTitle);
                    },
                    title: Text(trimmedTitle),
                    leading:
                        thumbnail(path: data, duration: videoinfo!.duration),
                    trailing: popupMenu(
                        index: index,
                        title: trimmedTitle,
                        videoPath: data,
                        fileSize: fileSize,
                        duration: videoinfo!.duration,
                        context: context),
                  ),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: videosList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: allVideos,
      builder: (BuildContext ctx, dynamic videosList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = videosList[index];
            AllVideos? videoinfo = videoDB.getAt(index);
            if (data.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.toString().split("/").last;
              String trimmedTitle = splittedTitle;

              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              file = data;
              return Column(
                children: [
                  ListTile(
                    onTap: () {
                      playVideo(
                          videotitle: splittedTitle,
                          context: context,
                          videoPath: data,
                          splittedvideotitle: trimmedTitle);
                    },
                    title: Text(trimmedTitle),
                    leading:
                        thumbnail(path: data, duration: videoinfo!.duration),
                    trailing: popupMenu(
                        index: index,
                        title: trimmedTitle,
                        videoPath: data,
                        fileSize: fileSize,
                        duration: videoinfo!.duration,
                        context: context),
                  ),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: videosList.length,
        );
      },
    );
  }
}

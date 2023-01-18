import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20widgets/popup_widget.dart';
import 'package:zineplayer/functions/functions.dart';

class FavSearch extends SearchDelegate {
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
      valueListenable: favouriteNotifier,
      builder: (BuildContext ctx, dynamic favList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = favList[index];
            if (data.videoPath.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.videoPath.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              file = data.videoPath;
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        playVideo(
                          videotitle: data.title,
                          context: context,
                          videoPath: data.videoPath,
                          splittedvideotitle: trimmedTitle,
                        );
                      },
                      trailing: popupMenu(
                          index: index,
                          title: data.title,
                          videoPath: data.videoPath,
                          fileSize: fileSize,
                          duration: data.duration,
                          context: context),
                      title: Text(trimmedTitle),
                      leading: thumbnail(
                          duration: data.duration, path: data.videoPath)),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: favList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: favouriteNotifier,
      builder: (BuildContext ctx, dynamic favList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = favList[index];
            if (data.videoPath.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.videoPath.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
              file = data.videoPath;
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        playVideo(
                          videotitle: data.title,
                          context: context,
                          videoPath: data.videoPath,
                          splittedvideotitle: trimmedTitle,
                        );
                      },
                      title: Text(trimmedTitle),
                      trailing: popupMenu(
                          index: index,
                          title: data.title,
                          videoPath: data.videoPath,
                          fileSize: fileSize,
                          duration: data.duration,
                          context: context),
                      leading: thumbnail(
                          duration: data.duration, path: data.videoPath)),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: favList.length,
        );
      },
    );
  }
}

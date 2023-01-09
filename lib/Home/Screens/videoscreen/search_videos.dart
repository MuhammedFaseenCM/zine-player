import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_all_videos.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/video_container.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/play_list_item_screen.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoSearch extends SearchDelegate {
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
            if (data.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
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
                    leading: thumbnail(),
                    trailing: popupMenu(
                        index: index, title: trimmedTitle, videoPath: data),
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
            if (data.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.toString().split("/").last;
              String trimmedTitle = splittedTitle;
              if (trimmedTitle.length > 20) {
                trimmedTitle = "${trimmedTitle.substring(0, 20)}...";
              }
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
                    leading: thumbnail(),
                    trailing: popupMenu(
                        index: index, title: trimmedTitle, videoPath: data),
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

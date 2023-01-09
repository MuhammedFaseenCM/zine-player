import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/play_list_item_screen.dart';
import 'package:zineplayer/functions/functions.dart';

class RecentSearch extends SearchDelegate {
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
            if (data.videoPath.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.videoPath.toString().split("/").last;
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
                            videoPath: data.videoPath,
                            splittedvideotitle: trimmedTitle,
                            durationinSec: data.durationinSec);
                      },
                      title: Text(trimmedTitle),
                      leading: thumbnail()),
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
            if (data.videoPath.toLowerCase().contains(query.toLowerCase())) {
              String splittedTitle = data.videoPath.toString().split("/").last;
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
                            videoPath: data.videoPath,
                            splittedvideotitle: trimmedTitle,
                            durationinSec: data.durationinSec);
                      },
                      title: Text(trimmedTitle),
                      leading: thumbnail()),
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

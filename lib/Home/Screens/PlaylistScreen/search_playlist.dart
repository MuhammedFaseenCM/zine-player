import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/playlistItemScreen.dart';
import 'package:zineplayer/functions/functions.dart';
import 'package:zineplayer/functions/datamodels.dart';

class Search extends SearchDelegate {
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
      builder: (BuildContext ctx, dynamic allvideos, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = allvideos[index];
            if (data.name.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) =>
                              PlayListItemScreen(items: data, index: index),
                        ));
                      },
                      title: Text(data.name),
                      leading: const Icon(Icons.folder)),
                  const Divider()
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: allvideos.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: allVideos,
      builder: (BuildContext ctx, dynamic studentList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = studentList[index];
            if (data.toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                      onTap: () {},
                      title: Text(data.toString().split("/").last),
                      leading: const Icon(Icons.folder)),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: studentList.length,
        );
      },
    );
  }
}

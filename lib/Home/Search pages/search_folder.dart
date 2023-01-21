import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_folders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/access_video_data.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/play_list_item_screen.dart';
import 'package:zineplayer/functions/functions.dart';

class FolderSearch extends SearchDelegate {
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
      valueListenable: loadFolders,
      builder: (BuildContext ctx, dynamic folderList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = folderList[index];
             if ((data.toString().split("/").last).toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                            VideoList(folderPath: loadFolders.value[index])));
                      },
                      title: Text(data.toString().split("/").last),
                      leading: const Icon(
                        Icons.folder,
                        size: 60.0,
                        color: Colors.blue,
                      )),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: folderList.length,
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: loadFolders,
      builder: (BuildContext ctx, dynamic folderList, Widget? child) {
        return ListView.builder(
          itemBuilder: (ctx, index) {
            final data = folderList[index];
           if ((data.toString().split("/").last).toLowerCase().contains(query.toLowerCase())) {
              return Column(
                children: [
                  ListTile(
                      onTap: () {
                        Navigator.of(context).push(createRoute(
                            VideoList(folderPath: loadFolders.value[index])));
                      },
                      title: Text(data.toString().split("/").last),
                      leading: const Icon(
                        Icons.folder,
                        size: 60.0,
                        color: Colors.blue,
                      )),
                  const Divider(),
                ],
              );
            } else {
              return Container();
            }
          },
          itemCount: folderList.length,
        );
      },
    );
  }
}

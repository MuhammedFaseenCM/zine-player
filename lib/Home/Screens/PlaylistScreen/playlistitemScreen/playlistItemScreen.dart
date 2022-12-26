import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/PlaylistFunctions.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayListItemScreen extends StatefulWidget {
  final PlayList items;
  final int? index;
  const PlayListItemScreen(
      {super.key, required this.items, required this.index});

  @override
  State<PlayListItemScreen> createState() => _PlayListItemScreenState();
}

class _PlayListItemScreenState extends State<PlayListItemScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.items.name),
        centerTitle: true,
      ),
      body: ValueListenableBuilder(
        builder: (BuildContext ctx, List<PlayListItems> playListitem,
            Widget? child) {
          return ListView.separated(
              itemBuilder: (context, index) {
                final listdata = playListitem[index];
                return Card(
                  child: ListTile(
                    leading: thumbnail(),
                    title: Text(listdata.title),
                    trailing: popupMenu(index: index),
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: playListitem.length);
        },
        valueListenable: playlistitemsNotifier,
      ),
    );
  }

  Widget popupMenu({required index}) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteFunction(index, context, deleteListItem(index));
            print("Playlist items : $index");
            //  Navigator.of(context).pop();
          },
          icon: const Icon(
            Icons.delete,
            color: Colors.red,
          ),
          label: const Text(
            "Delete from playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/mainScreen.dart';
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
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.items.name),
          centerTitle: true,
          flexibleSpace: appbarcontainer(),
          backgroundColor: Colors.transparent,
        ),
        body: ValueListenableBuilder(
          builder: (BuildContext ctx, List<PlayListItems> playListitem,
              Widget? child) {
            return ListView.separated(
                itemBuilder: (context, index) {
                  final listdata = playListitem[index];
                  // if (widget.index == listdata.index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        addToRecentList(
                            title: listdata.title, context: context);
                      },
                      leading: thumbnail(),
                      title: Text(listdata.title),
                      trailing: popupMenu(index: index),
                    ),
                  );
                },
                //     return SizedBox();
                // },
                separatorBuilder: (context, index) {
                  return const Divider();
                },
                itemCount: playListitem.length);
          },
          valueListenable: playlistitemsNotifier,
        ),
      ),
    );
  }

  Widget popupMenu({required index}) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteListItem(index: index, context: context);
            print("Playlist items : $index");
            snackBar(
                context: context,
                content: "Successfully deleted",
                bgcolor: Colors.green);
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

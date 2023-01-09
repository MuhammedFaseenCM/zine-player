import 'package:flutter/material.dart';
import 'package:zineplayer/Home/main_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayListItemScreen extends StatefulWidget {
  final PlayList items;
  final String videoPath;
  // final int? index;
  const PlayListItemScreen(
      {super.key, required this.items, required this.videoPath});

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
            if (playListitem == null) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (playListitem.isEmpty) {
              return const Center(
                child: Text("No videos available"),
              );
            } else {
              return ListView.builder(
                  itemBuilder: (context, index) {
                    final listdata = playListitem[index];

                    String title =
                        listdata.videoPath.toString().split("/").last;
                    String shorttitle = title;
                    if (title.length > 20) {
                      shorttitle = "${shorttitle.substring(0, 20)}...";
                    }
                    if (widget.items.name == listdata.playlistFolderName) {
                      return Card(
                        child: ListTile(
                          onTap: () {
                            playVideo(
                                videotitle: title,
                                context: context,
                                videoPath: listdata.videoPath,
                                splittedvideotitle: shorttitle);
                          },
                          leading: thumbnail(),
                          title: Text(shorttitle),
                          trailing: popupMenu(index: index),
                        ),
                      );
                    } else {
                      return const SizedBox();
                    }
                  },
                  itemCount: playListitem.length);
            }
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/search_playlist.dart';
import 'package:zineplayer/Home/mainScreen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class VideoPlayerScreen extends StatefulWidget {
  final String folderName;
  const VideoPlayerScreen({super.key, required this.folderName});

  @override
  State<VideoPlayerScreen> createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
//  late VideoPlayerController _controller;
//  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();

    // Create and store the VideoPlayerController. The VideoPlayerController
    // offers several different constructors to play videos from assets, files,
    // or the internet.
    //  _controller = VideoPlayerController.network(
    //   '',
    //  );

    // Initialize the controller and store the Future for later use.
    //   _initializeVideoPlayerFuture = _controller.initialize();

    // Use the controller to loop the video.
    // _controller.setLooping(true);
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    //   _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: Text(widget.folderName),
          flexibleSpace: appbarcontainer(),
          actions: [
            IconButton(
                onPressed: () {
                  showSearch(context: context, delegate: Search());
                },
                icon: const Icon(Icons.search))
          ],
        ),
        body: ListView.separated(
            itemBuilder: (context, index) {
              String videopaths = videopath[index];
              List<String> pathparts = videopaths.split(Platform.pathSeparator);
              String videotitle = pathparts.last;
              //  File videoFile = File(videopaths);
              //    String videoSize = videoFile.lengthSync().toString();
              return ListTile(
                onTap: () {
                  addToRecentList(title: videotitle, context: context);
                  //  addToPlayList(context: context, listIndex: index);
                },
                title: Text(videotitle),
                subtitle: Text("path : " + videopath[index]),
                leading: thumbnail(),
                trailing: popupMenu(index: index, title: videotitle),
              );
            },
            separatorBuilder: (context, index) => const Divider(),
            itemCount: videopath.length),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.play_arrow),
          onPressed: () {},
        ),
      ),
    );
  }

  Widget popupMenu({required index, required title}) {
    //  playScreen playscreen = playScreen();
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            addToFavourite(title: title, context: context);
            print(index);
          },
          icon: const Icon(Icons.favorite),
          label: const Text(
            "Add to favourite",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        )),
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            addToPlayList(
                context: context, listIndex: index, videotitle: title);
            print(index);
            //Navigator.of(context).pop();
          },
          icon: const Icon(Icons.playlist_add),
          label: const Text(
            "Add to playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }

  void addToPlayList(
      {required BuildContext context,
      required listIndex,
      required videotitle}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Select playlist"),
          content:
              playlistDailog(listIndex: listIndex, videotitle: videotitle)),
    );
  }

  Widget playlistDailog({required listIndex, required videotitle}) {
    return Container(
      height: 150.0,
      width: 200.0,
      color: Colors.purple,
      child: ValueListenableBuilder(
        valueListenable: playListNotifier,
        builder:
            (BuildContext context, List<PlayList> playlist, Widget? child) {
          return ListView.builder(
              shrinkWrap: true,
              itemBuilder: (context, index) {
                final listdata = playlist[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      addItemToPlayList(title: videotitle, context: context);
                      snackBar(
                          context: context,
                          content: 'Successfully added',
                          bgcolor: Colors.green);
                    },
                    title: Text(listdata.name),
                  ),
                );
              },
              itemCount: playlist.length);
        },
      ),
    );
  }
}

Widget thumbnail() {
  return Container(
    height: 50.0,
    width: 70.0,
    color: Colors.grey,
    child: const Icon(
      Icons.movie_filter_outlined,
      color: Colors.white,
    ),
  );
}

var demoList = [
  'India',
  'Australia',
  'England',
  'New zealand',
  'Bangladesh',
  'Pakistan',
  'West indies'
];

List<String> videopath = [
  'assets/messi video.mp4',
  'assets/videos/kakkakuyil.mp4',
  'assets/videos/mohanlal lucifer.mp4',
  'assets/videos/singam.mp4'
];

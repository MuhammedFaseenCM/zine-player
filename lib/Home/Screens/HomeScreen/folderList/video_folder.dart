import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/listitemFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/search_playlist.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.folderName),
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
            return ListTile(
              onTap: () {
                addToRecentList(title: demoList[index], context: context);
                //  addToPlayList(context: context, listIndex: index);
              },
              title: Text(demoList[index]),
              leading: thumbnail(),
              trailing: popupMenu(index: index, title: demoList[index]),
            );
          },
          separatorBuilder: (context, index) => const Divider(),
          itemCount: demoList.length),
      // Use a FutureBuilder to display a loading spinner while waiting for the
      // VideoPlayerController to finish initializing.
      // body: FutureBuilder(
      //   future: _initializeVideoPlayerFuture,
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.done) {
      //       // If the VideoPlayerController has finished initialization, use
      //       // the data it provides to limit the aspect ratio of the video.
      //       return AspectRatio(
      //         aspectRatio: _controller.value.aspectRatio,
      //         // Use the VideoPlayer widget to display the video.
      //         child: VideoPlayer(_controller),
      //       );
      //     } else {
      //       // If the VideoPlayerController is still initializing, show a
      //       // loading spinner.
      //       return const Center(
      //         child: CircularProgressIndicator(),
      //       );
      //     }
      //   },
      // ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.play_arrow),
        onPressed: () {
          // Wrap the play or pause in a call to `setState`. This ensures the
          // correct icon is shown.
          setState(() {
            // If the video is playing, pause it.
            // if (_controller.value.isPlaying) {
            //   _controller.pause();
            // } else {
            //   // If the video is paused, play it.
            //   _controller.play();
            // }
          });
        },
        // Display the correct icon depending on the state of the player.
        // child: Icon(
        //   _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
        // ),
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
            addToPlayList(context: context, listIndex: index);
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

  var demoList = [
    'India',
    'Australia',
    'England',
    'New zealand',
    'Bangladesh',
    'Pakistan',
    'West indies'
  ];

  void addToPlayList({required BuildContext context, required listIndex}) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
          title: const Text("Select playlist"),
          content: playlistDailog(listIndex: listIndex)),
    );
  }

  Widget playlistDailog({required listIndex}) {
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
                      addItemToPlayList(
                          title: demoList[listIndex], context: context);
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

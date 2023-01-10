import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:video_player/video_player.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class FolderVideoContainer extends StatefulWidget {
  final String videoPath;
  final int index;
  final String videotitle;
  final String splittitle;
  const FolderVideoContainer(
      {super.key,
      required this.videoPath,
      required this.index,
      required this.videotitle,
      required this.splittitle});

  @override
  State<FolderVideoContainer> createState() => _FolderVideoContainerState();
}

class _FolderVideoContainerState extends State<FolderVideoContainer> {
  late VideoPlayerController _controller;
  Duration _duration = const Duration();
  int? durationinSecs = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.file(File(widget.videoPath));
    _controller.initialize().then((_) {
      setState(() {
        _duration = _controller.value.duration;
      });
    });
    recentdbdata();
  }

  recentdbdata() async {
    final box = await Hive.openBox<RecentList>('recentlistBox');
    List<RecentList> data = box.values.toList();
    List<RecentList> result = data
        .where((contains) => contains.videoPath == widget.videoPath)
        .toList();
    if (result.isNotEmpty) {
      durationinSecs = result
          .where((element) => element.videoPath == widget.videoPath)
          .first
          ?.durationinSec;
    }
    box.close();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          playVideo(
              videotitle: widget.videotitle,
              context: context,
              videoPath: widget.videoPath,
              splittedvideotitle: widget.splittitle,
              durationinSec: durationinSecs);
        },
        //  isThreeLine: true,
        leading: thumbnail(duration: _duration.toString().split(".").first),
        title: Text(widget.splittitle),
        trailing: popupMenu(
            index: widget.index,
            title: widget.videotitle,
            videoPath: widget.videoPath,
            fileSize: fileSize,
            duration: _duration.toString().split(".").first),
      ),
    );
  }

  String get fileSize {
    final fileSizeInBytes = File(widget.videoPath).lengthSync();
    return filesizing(fileSizeInBytes);
  }
}

String filesizing(fileSizeInBytes) {
  if (fileSizeInBytes < 1024) {
    return '$fileSizeInBytes bytes';
  }
  if (fileSizeInBytes < 1048576) {
    return '${(fileSizeInBytes / 1024).toStringAsFixed(1)} KB';
  }
  if (fileSizeInBytes < 1073741824) {
    return '${(fileSizeInBytes / 1048576).toStringAsFixed(1)} MB';
  }
  return '${(fileSizeInBytes / 1073741824).toStringAsFixed(1)} GB';
}

Widget popupMenu(
    {required index,
    required title,
    required videoPath,
    required fileSize,
    required duration}) {
  return PopupMenuButton(
    itemBuilder: (context) => [
      PopupMenuItem(
          onTap: () => showDetails(
              context: context,
              title: title,
              path: videoPath,
              duration: duration,
              size: fileSize),
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.info_outline, color: Colors.purple),
                onPressed: () {
                  showDetails(
                      context: context,
                      title: title,
                      path: videoPath.toString().split(title).first,
                      duration: duration,
                      size: fileSize);
                },
              ),
              const SizedBox(
                width: 10.0,
              ),
              const Text("Details",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold))
            ],
          )),
      PopupMenuItem(
          onTap: () {
            addToFavourite(
                title: title, context: context, videoPath: videoPath);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.favorite,
                color: Colors.purple,
              ),
              SizedBox(
                width: 10.0,
              ),
              Text("Like",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold))
            ],
          )),
      PopupMenuItem(
          onTap: () {
            // addToPlayList(context: context, widgetpath: videoPath);
          },
          child: SizedBox(
            width: 101.0,
            child: TextButton.icon(
              icon: const Icon(
                Icons.playlist_add,
                color: Colors.purple,
              ),
              label: const Text("Add to playlist",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 15.0,
                      fontWeight: FontWeight.bold)),
              onPressed: () =>
                  addToPlayList(context: context, widgetpath: videoPath),
            ),
          ))
    ],
  );
}

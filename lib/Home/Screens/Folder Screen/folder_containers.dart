import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_folders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/access_video_data.dart';
import 'package:zineplayer/functions/functions.dart';

class FolderContainer extends StatefulWidget {
  final int index;
  // final dynamic folderlist;
  // final dynamic fullPath;
  const FolderContainer({
    super.key,
    required this.index,
    //required this.folderlist,
    //required this.fullPath
  });

  @override
  State<FolderContainer> createState() => _FolderContainerState();
}

class _FolderContainerState extends State<FolderContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(createRoute(
                VideoList(folderPath: loadFolders.value[widget.index])));
          },
          title: Text(loadFolders.value[widget.index].split("/").last),
          leading: const Icon(
            Icons.folder,
            size: 60.0,
            color: Colors.blue,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_folders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/access_video_data.dart';
import 'package:zineplayer/functions/functions.dart';

class FolderContainer extends StatelessWidget {
  final int index;

  const FolderContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    // loadFolders.value.sort((a, b) {
    //   return a.toLowerCase().compareTo(b.toLowerCase());
    // });
    return SizedBox(
      height: 80,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(
                createRoute(VideoList(folderPath: loadFolders.value[index])));
          },
          title: Text(loadFolders.value[index].split("/").last),
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

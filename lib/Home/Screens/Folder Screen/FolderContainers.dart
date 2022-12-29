import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';

class FolderContainer extends StatelessWidget {
  int index;
  String folderName;
  FolderContainer({super.key, required this.index, required this.folderName});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(loadFolders.value[index].split("/").last),
        leading: Icon(
          Icons.folder,
          size: 50.0,
        ),
      ),
    );

    //  Container(
    //   child: Row(
    //     children: [
    //       Icon(Icons.folder),
    //       Text(loadFolders.value[index].split("/").last)
    //     ],
    //   ),
    // );
  }
}

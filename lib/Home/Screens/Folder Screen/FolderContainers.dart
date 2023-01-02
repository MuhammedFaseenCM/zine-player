import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';
import 'package:zineplayer/AccessFolders/loadVideos.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/accessVideoData.dart';

class FolderContainer extends StatelessWidget {
  int index;

  FolderContainer({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    loadFolders.value.sort((a, b) {
      //sorting in ascending order
      return a.toLowerCase().compareTo(b.toLowerCase());
    });
    //(a, b) => a.length.compareTo(b.length));

    //log(loadFolders.value[index].split("/").last);
    return Container(
      height: 80,
      child: Card(
        child: ListTile(
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
              builder: (context) =>
                  VideoList(folderPath: loadFolders.value[index]),
            ));
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

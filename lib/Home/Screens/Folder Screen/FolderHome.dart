import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';
import 'package:zineplayer/AccessFolders/loadAllVideos.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';
import 'package:zineplayer/AccessFolders/loadVideos.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/FolderContainers.dart';
import 'package:zineplayer/Home/Screens/splashScreen.dart';

class FolderHome extends StatelessWidget {
  const FolderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
          valueListenable: loadFolders,
          builder: (BuildContext context, dynamic folderlist, Widget) {
            return ListView.builder(
                itemBuilder: (context, index) {
                  return FolderContainer(
                    index: index,
                  );
                },
                itemCount: folderlist.length);
          }),
    );
  }
}

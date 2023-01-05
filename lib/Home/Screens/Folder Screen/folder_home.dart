import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_folders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/folder_containers.dart';

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

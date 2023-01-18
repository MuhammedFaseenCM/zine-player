import 'package:flutter/material.dart';
import 'package:zineplayer/AccessFolders/load_folders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/folder_containers.dart';

class FolderHome extends StatelessWidget {
  const FolderHome({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
        valueListenable: loadFolders,
        builder: (BuildContext context, dynamic folderlist, _) {
          return ListView.builder(
              itemBuilder: (context, index) {
                return FolderContainer(
                  index: index,
                );
              },
              itemCount: folderlist.length);
        });
  }
}




















          // dynamic folderList = folderlist.toList();
          // folderList.sort();
          // List<String> folderTitle = [];
          // List<String> fullPath = [];
          // for (var i = 0; i < loadFolders.value.length; i++) {
          //   String title = loadFolders.value[i].split("/").last;
          //   folderTitle.add(title);
          //   String path = loadFolders.value[i].split("/").first;
          //   // log(path);
          //   String foldername = path.split("emulated").last;
          //   folderTitle.add(foldername);
          //   log(foldername);
          // }
          // folderTitle
          //     .sort(((a, b) => a.toLowerCase().compareTo(b.toLowerCase())));

          // for (var i = 0; i < loadFolders.value.length; i++) {
          //   for (var j = 0; j < loadFolders.value.length; j++) {
          //     if (folderTitle[i] == folderlist[j].split("/").last) {
          //       fullPath.add(loadFolders.value[j]);
          //       //     folderlist[j] = "";
          //       break;
          //     }
          //   }
          // }
          // log(folderlist[1]);



                            // folderlist: folderTitle,
                  // fullPath: fullPath,
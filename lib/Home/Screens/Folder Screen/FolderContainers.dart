import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:zineplayer/AccessFolders/AccessVideos.dart';
import 'package:zineplayer/AccessFolders/loadFolders.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/accessVideoData.dart';

class FolderContainer extends StatelessWidget {
  int index;
  String folderName;
  FolderContainer({super.key, required this.index, required this.folderName});

  @override
  Widget build(BuildContext context) {
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
          subtitle: Text("${loadFolders.value[index].length} Videos"),
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

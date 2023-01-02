import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/Home/Screens/Folder%20Screen/VideoScreen.dart';

class Home_screen extends StatelessWidget {
  Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          child: ListTile(
            onTap: () {
              // Navigator.of(context).push(MaterialPageRoute(
              //     builder: (context) => VideoPlayerScreen(
              //           folderName: foldername[index],
              //          videolist: filelist[index],
              //         )));
            },
            leading: const Icon(
              Icons.folder,
              size: 50.0,
            ),
            title: Text(foldername[index]),
          ),
        );
      },
      itemCount: foldername.length,
    );
  }

  final foldername = [
    'Folder 1',
    'Folder 2',
    'Folder 3',
    'Folder 4',
  ];
}

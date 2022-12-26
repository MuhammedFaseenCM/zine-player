import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';

class Home_screen extends StatelessWidget {
  Home_screen({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => VideoPlayerScreen(
                        folderName: foldername[index],
                      )));
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
    'Download',
    'Movies',
    'Videos',
    'Whatsapp video',
  ];
}

import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/favFunction.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/ListFunctions.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/video_folder.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      builder: (BuildContext ctx, List<Favourite> favList, Widget? child) {
        return ListView.separated(
            itemBuilder: (context, index) {
              final listdata = favList[index];
              return Card(
                child: ListTile(
                  onTap: () {
                    addToRecentList(title: demoList[index], context: context);
                  },
                  leading: thumbnail(),
                  title: Text(listdata.title),
                  trailing: popupMenu(index),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const Divider();
            },
            itemCount: favList.length);
      },
      valueListenable: favouriteNotifier,
    );
  }

  Widget popupMenu(index) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteFav(index);
            snackBar(
                context: context,
                content: "Successfully deleted",
                bgcolor: Colors.green);
            print("deleted $index from favouritelist");
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text(
            "Delete from favourites",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }
}

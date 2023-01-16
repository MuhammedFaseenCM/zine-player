import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/FavScreen/fav_video.dart';
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
              String splittedtitle = listdata.title;
              if (splittedtitle.length > 20) {
                splittedtitle = "${splittedtitle.substring(0, 20)}...";
              }
              return FavouriteVideo(
                title: listdata.title,
                path: listdata.videoPath,
                trimtitle: splittedtitle,
                index: index,
                duration: listdata.duration,
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
}

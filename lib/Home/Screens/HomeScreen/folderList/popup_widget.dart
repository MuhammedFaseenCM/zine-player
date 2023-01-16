import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlist_widget.dart';
import 'package:zineplayer/functions/functions.dart';

Widget popupMenu(
    {required index,
    required title,
    required videoPath,
    required fileSize,
    required duration,
    isFav = true,
    bool isPlaylist = true,
    required context}) {
  TextTheme textTheme = Theme.of(context).textTheme;
  return PopupMenuButton(
    itemBuilder: (context) => [
      PopupMenuItem(
          child: TextButton.icon(
              onPressed: () {
                Navigator.of(context).pop();
                showDetails(
                    context: context,
                    title: title,
                    path: videoPath.toString().split("/$title").first,
                    duration: duration,
                    size: fileSize);
              },
              icon: const Icon(Icons.info_rounded),
              label: Text(details, style: textTheme.subtitle1))),
      PopupMenuItem(
          onTap: () {
            addToFavourite(
                title: title,
                context: context,
                videoPath: videoPath,
                duration: duration);
          },
          child: isFav
              ? TextButton.icon(
                  icon: Icon(
                    Icons.favorite,
                    color: red,
                  ),
                  label: Text(like, style: textTheme.subtitle1),
                  onPressed: () {
                    addToFavourite(
                        title: title,
                        context: context,
                        videoPath: videoPath,
                        duration: duration);
                    Navigator.of(context).pop();
                  })
              : TextButton.icon(
                  onPressed: () {
                    deleteFav(index);
                    snackBar(
                        context: context, content: unLiked, bgcolor: green);
                    Navigator.of(context).pop();
                  },
                  icon: Icon(Icons.remove, color: red),
                  label: Text(
                    unLike,
                    style: textTheme.subtitle1,
                  ),
                )),
      PopupMenuItem(
          child: SizedBox(
              width: 101.0,
              child: isPlaylist
                  ? TextButton.icon(
                      icon: Icon(
                        Icons.playlist_add,
                        color: purplecolor,
                      ),
                      label: Text(addtoplaylist, style: textTheme.subtitle1),
                      onPressed: () {
                        return addToPlayList(
                            context: context,
                            widgetpath: videoPath,
                            duration: duration);
                      })
                  : TextButton.icon(
                      onPressed: () {
                        deleteListItem(index: index, context: context);
                        snackBar(
                            context: context, content: deleted, bgcolor: green);
                      },
                      icon: Icon(
                        Icons.delete,
                        color: red,
                      ),
                      label:
                          Text(deletefromplaylist, style: textTheme.subtitle1),
                    )))
    ],
  );
}

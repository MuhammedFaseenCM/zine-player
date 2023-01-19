import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/folderList/colors_and_texts.dart';
import 'package:zineplayer/Home/Screen%20functions/play_list_functions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/play_list_item_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({
    super.key,
  });

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  @override
  void initState() {
    getPlayList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getPlayList();
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 200.0),
            child: ElevatedButton.icon(
              onPressed: () {
                newPlayListDialog(context, formKey, newPlayListController);
              },
              icon: Icon(
                Icons.add,
                color: purplecolor,
              ),
              label: Text(
                createPlaylist,
                style: TextStyle(color: purplecolor),
              ),
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(white)),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              builder:
                  (BuildContext ctx, List<PlayList> playList, Widget? child) {
                return ListView.separated(
                    itemBuilder: (context, index) {
                      final listdata = playList[index];
                      return Card(
                        child: ListTile(
                          onTap: () {
                            Navigator.of(context).push(createRoute(
                                PlayListItemScreen(
                                    items: listdata,
                                    videoPath: listdata.name)));
                          },
                          leading: Icon(
                            Icons.folder,
                            size: 60.0,
                            color: bluecolor,
                          ),
                          title: Text(listdata.name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.normal)),
                          trailing:
                              popupMenu(index, listdata.name, listdata.index),
                        ),
                      );
                    },
                    separatorBuilder: (context, index) {
                      return const Divider();
                    },
                    itemCount: playList.length);
              },
              valueListenable: playListNotifier,
            ),
          ),
        ],
      ),
    );
  }

  Widget popupMenu(index, name, listIndex) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            updatePlayListDialog(index, name, listIndex);
          },
          icon: const Icon(Icons.edit),
          label: Text(
            editPlaylist,
            style: textTheme.subtitle1,
          ),
        )),
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deleteFunction(index, context);
          },
          icon: Icon(Icons.delete, color: red),
          label: Text(
            deletePlaylist,
            style: textTheme.subtitle1,
          ),
        ))
      ],
    );
  }

  void updatePlayListDialog(index, name, listIndex) {
    newPlayListController.text = name.toString();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(updatePlaylistText),
        content: Form(
            key: formKey,
            child: Padding(
              padding: (const EdgeInsets.only(top: 0, bottom: 4)),
              child: TextFormField(
                controller: newPlayListController,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: playListText,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return noEmpty;
                  } else {
                    return null;
                  }
                },
              ),
            )),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(cancel)),
          TextButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  updatePlaylist(
                      index, context, newPlayListController, listIndex);
                }
              },
              child: Text(ok))
        ],
      ),
    );
  }
}

void newPlayListDialog(BuildContext context, formKey, newPlayListController) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(createPlaylistText),
      content: Form(
          key: formKey,
          child: Padding(
            padding: (const EdgeInsets.only(top: 0, bottom: 4)),
            child: TextFormField(
              controller: newPlayListController,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                labelText: playListText,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return noEmpty;
                } else {
                  return null;
                }
              },
            ),
          )),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(cancel)),
        TextButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                createplaylistfn(context, newPlayListController);
              }
            },
            child: Text(ok))
      ],
    ),
  );
}

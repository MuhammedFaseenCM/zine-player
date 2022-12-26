import 'package:flutter/material.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/PlaylistFunctions.dart';
import 'package:zineplayer/Home/Screens/PlaylistScreen/playlistitemScreen/playlistItemScreen.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

class PlayScreen extends StatefulWidget {
  const PlayScreen({super.key});

  @override
  State<PlayScreen> createState() => _PlayScreenState();
}

class _PlayScreenState extends State<PlayScreen> {
  final _newPlayListController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("Ready to create playlist");
          newPlayListDialog(context);
          // Perform the action
        },
        child: const Icon(Icons.add),
      ),
      body: ValueListenableBuilder(
        builder: (BuildContext ctx, List<PlayList> playList, Widget? child) {
          return ListView.builder(
              itemBuilder: (context, index) {
                final listdata = playList[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlayListItemScreen(
                            items: listdata, index: listdata.index),
                      ));
                    },
                    leading: const Icon(
                      Icons.folder,
                      size: 50.0,
                    ),
                    title: Text(listdata.name),
                    trailing: popupMenu(index),
                  ),
                );
              },
              itemCount: playList.length);
        },
        valueListenable: playListNotifier,
      ),
    );
  }

  void newPlayListDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create playlist"),
        content: Form(
            key: _formKey,
            child: Padding(
              padding: (const EdgeInsets.only(top: 0, bottom: 4)),
              child: TextFormField(
                controller: _newPlayListController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Playlist",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty not allowed";
                  } else {
                    return null;
                  }
                },
              ),
            )),
        actions: [
          TextButton(
              onPressed: () {
                print("Cancelled");
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  createplaylistfn(context, _newPlayListController);
                }
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }

  Widget popupMenu(index) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            updatePlayListDialog(index);
            print(index);
          },
          icon: const Icon(Icons.edit),
          label: const Text(
            "Edit playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        )),
        PopupMenuItem(
            child: TextButton.icon(
          onPressed: () {
            deletePlayList(index);
            print(index);
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.delete, color: Colors.red),
          label: const Text(
            "Delete playlist",
            style: TextStyle(color: Colors.black, fontSize: 15.0),
          ),
        ))
      ],
    );
  }

  void updatePlayListDialog(index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update playlist"),
        content: Form(
            key: _formKey,
            child: Padding(
              padding: (const EdgeInsets.only(top: 0, bottom: 4)),
              child: TextFormField(
                controller: _newPlayListController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Playlist",
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Empty not allowed";
                  } else {
                    return null;
                  }
                },
              ),
            )),
        actions: [
          TextButton(
              onPressed: () {
                print("Cancelled");
                Navigator.of(context).pop();
              },
              child: const Text("Cancel")),
          TextButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  updatePlaylist(index, context, _newPlayListController);
                }
              },
              child: const Text("Ok"))
        ],
      ),
    );
  }
}

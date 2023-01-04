import 'package:flutter/material.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/functions/functions.dart';

createplaylistfn(context, newPlayListController) {
  final name = newPlayListController.text.trim();
  final list = PlayList(name: name);
  if (name.isEmpty) {
    return;
  }
  playlistdb(list);
  newPlayListController.clear();
  Navigator.of(context).pop();
}

updatePlaylist(index, context, newPlayListController) async {
  final name = newPlayListController.text.trim();
  final updatedlist = PlayList(name: name);
  if (name.isEmpty) {
    return;
  }
  await updatePlayList(updatedlist, index);
  Navigator.of(context).pop();
  Navigator.of(context).pop();
}

Future<void> deleteFunction(int index, context) async {
  showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Are you sure want to delete ?'),
          actions: [
            TextButton(
                onPressed: () {
                  deletePlayList(index);
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                  snackBar(
                      content: "Successfully deleted",
                      context: context,
                      bgcolor: Colors.green);
                },
                child: const Text('Yes')),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },
                child: const Text('No'))
          ],
        );
      });
}

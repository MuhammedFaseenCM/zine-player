import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/functions/datamodels.dart';
import 'package:zineplayer/Home/mainScreen.dart';

void main() async {
  await Hive.initFlutter();
  adapterRegisterFunction();
  runApp(const zinePlayer());
}

class zinePlayer extends StatelessWidget {
  const zinePlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: MainScreen(),
    );
  }
}

adapterRegisterFunction() {
  if (!Hive.isAdapterRegistered(PlayListAdapter().typeId)) {
    Hive.registerAdapter(PlayListAdapter());
  }
  if (!Hive.isAdapterRegistered(FavouriteAdapter().typeId)) {
    Hive.registerAdapter(FavouriteAdapter());
  }
  if (!Hive.isAdapterRegistered(PlayListItemsAdapter().typeId)) {
    Hive.registerAdapter(PlayListItemsAdapter());
  }
  if (!Hive.isAdapterRegistered(RecentListAdapter().typeId)) {
    Hive.registerAdapter(RecentListAdapter());
  }
}

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/splash_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';

void main() async {
  await Hive.initFlutter();
  adapterRegisterFunction();
  runApp(const Zineplayer());
}

class Zineplayer extends StatelessWidget {
  const Zineplayer({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.purple),
      home: const SplashScreen(),
    );
  }
}

adapterRegisterFunction() async {
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
  await Hive.openBox('resumeBox');
}

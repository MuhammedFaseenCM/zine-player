import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:zineplayer/Home/Screens/HomeScreen/drawer/settings.dart';
import 'package:zineplayer/Home/Screens/Starting%20Screens/splash_screen.dart';
import 'package:zineplayer/functions/datamodels.dart';

void main() async {
  await Hive.initFlutter();
  adapterRegisterFunction();
  runApp(const Zineplayer());
}
ThemeManager themeManager = ThemeManager();
late Box<AllVideos> videoDB;
class Zineplayer extends StatefulWidget {
  const Zineplayer({super.key});

  @override
  State<Zineplayer> createState() => _ZineplayerState();
}

class _ZineplayerState extends State<Zineplayer> {
  @override
  void initState() {
    themeManager.addListener(themeListener);
    super.initState();
  }

  @override
  void dispose() {
    themeManager.removeListener(themeListener);
    super.dispose();
  }

  themeListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: darkTheme,
      theme: lightTheme,
      themeMode: themeManager.themeMode,
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
  if (!Hive.isAdapterRegistered(FrameColorAdapter().typeId)) {
    Hive.registerAdapter(FrameColorAdapter());
  }
  if (!Hive.isAdapterRegistered(AllVideosAdapter().typeId)) {
    Hive.registerAdapter(AllVideosAdapter());
  }
  videoDB = await Hive.openBox<AllVideos>('videoplayer');
}

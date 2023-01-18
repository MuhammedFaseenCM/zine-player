import 'package:hive_flutter/hive_flutter.dart';
part 'datamodels.g.dart';

@HiveType(typeId: 1)
class PlayList {
  @HiveField(0)
  int? index;
  @HiveField(1)
  final String name;
  PlayList({required this.name, this.index});
}

@HiveType(typeId: 2)
class Favourite {
  @HiveField(0)
  int? index;
  @HiveField(1)
  final String title;

  @HiveField(2)
  final String videoPath;
  @HiveField(3)
  final String duration;
  Favourite(
      {required this.title,
      this.index,
      required this.videoPath,
      required this.duration});
}

@HiveType(typeId: 3)
class PlayListItems {
  @HiveField(0)
  String videoPath;
  @HiveField(1)
  String playlistFolderName;
  @HiveField(2)
  String duration;
  PlayListItems(
      {required this.videoPath,
      required this.playlistFolderName,
      required this.duration});
}

@HiveType(typeId: 4)
class RecentList {
  @HiveField(0)
  int? index;

  @HiveField(1)
  final String videoPath;

  @HiveField(2)
  final int duration;

  @HiveField(3)
  final int durationinSec;

  RecentList({
    this.index,
    required this.videoPath,
    required this.duration,
    required this.durationinSec,
  });
}

@HiveType(typeId: 5)
class FrameColor {
  @HiveField(0)
  int? index;
  @HiveField(1)
  String color;
  FrameColor({required this.color});
}

@HiveType(typeId: 6)
class AllVideos {
  @HiveField(0)
  final String duration;
  @HiveField(1)
  final String path;
  AllVideos({required this.duration, required this.path});
}

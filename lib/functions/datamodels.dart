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

  Favourite({required this.title, this.index, required this.videoPath});
}

@HiveType(typeId: 3)
class PlayListItems {
  @HiveField(0)
  String videoPath;
  @HiveField(1)
  String playlistFolderName;
  PlayListItems({required this.videoPath, required this.playlistFolderName});
}

@HiveType(typeId: 4)
class RecentList {
  @HiveField(0)
  int? index;

  @HiveField(1)
  final String videoPath;

  @HiveField(2)
  final String duration;

  @HiveField(3)
  final int durationinSec;

  RecentList({
    this.index,
    required this.videoPath,
    required this.duration,
    required this.durationinSec,
  });
}

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
  Favourite({required this.title, this.index});
}

@HiveType(typeId: 3)
class PlayListItems {
  @HiveField(0)
  int? index;
  @HiveField(1)
  final String title;
  PlayListItems({required this.title});
}

@HiveType(typeId: 4)
class RecentList {
  @HiveField(0)
  final String title;

  RecentList({required this.title});
}

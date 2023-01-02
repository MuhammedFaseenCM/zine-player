// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'datamodels.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PlayListAdapter extends TypeAdapter<PlayList> {
  @override
  final int typeId = 1;

  @override
  PlayList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayList(
      name: fields[1] as String,
      index: fields[0] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PlayList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class FavouriteAdapter extends TypeAdapter<Favourite> {
  @override
  final int typeId = 2;

  @override
  Favourite read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Favourite(
      title: fields[1] as String,
      index: fields[0] as int?,
      videoPath: fields[2] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Favourite obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.videoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FavouriteAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PlayListItemsAdapter extends TypeAdapter<PlayListItems> {
  @override
  final int typeId = 3;

  @override
  PlayListItems read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PlayListItems(
      title: fields[1] as String,
    )..index = fields[0] as int?;
  }

  @override
  void write(BinaryWriter writer, PlayListItems obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.title);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PlayListItemsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class RecentListAdapter extends TypeAdapter<RecentList> {
  @override
  final int typeId = 4;

  @override
  RecentList read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return RecentList(
      index: fields[0] as int?,
      videoPath: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, RecentList obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.index)
      ..writeByte(1)
      ..write(obj.videoPath);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RecentListAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

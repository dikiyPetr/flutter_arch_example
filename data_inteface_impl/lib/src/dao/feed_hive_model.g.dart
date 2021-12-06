// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed_hive_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class FeedHiveModelAdapter extends TypeAdapter<FeedHiveModel> {
  @override
  final int typeId = 0;

  @override
  FeedHiveModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return FeedHiveModel(
      fields[0] as String,
      fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, FeedHiveModel obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FeedHiveModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

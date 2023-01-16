// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class NewsmodelAdapter extends TypeAdapter<Newsmodel> {
  @override
  final int typeId = 1;

  @override
  Newsmodel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Newsmodel(
      date: fields[4] as String,
      description: fields[3] as String,
      imgurl: fields[2] as String,
      newstitle: fields[0] as String,
      sourse: fields[1] as String,
    );
  }

  @override
  void write(BinaryWriter writer, Newsmodel obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.newstitle)
      ..writeByte(1)
      ..write(obj.sourse)
      ..writeByte(2)
      ..write(obj.imgurl)
      ..writeByte(3)
      ..write(obj.description)
      ..writeByte(4)
      ..write(obj.date);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NewsmodelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

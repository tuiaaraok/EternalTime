// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'watch_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class WatchModelAdapter extends TypeAdapter<WatchModel> {
  @override
  final int typeId = 1;

  @override
  WatchModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WatchModel(
      image: fields[0] as Uint8List,
      brandName: fields[1] as String,
      serialNumber: fields[2] as String,
      series: fields[3] as String,
      cost: fields[4] as String,
      typeOfWatch: fields[5] as String,
      mechanism: fields[6] as String,
      strapType: fields[7] as String,
      glassMaterial: fields[8] as String,
    );
  }

  @override
  void write(BinaryWriter writer, WatchModel obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.image)
      ..writeByte(1)
      ..write(obj.brandName)
      ..writeByte(2)
      ..write(obj.serialNumber)
      ..writeByte(3)
      ..write(obj.series)
      ..writeByte(4)
      ..write(obj.cost)
      ..writeByte(5)
      ..write(obj.typeOfWatch)
      ..writeByte(6)
      ..write(obj.mechanism)
      ..writeByte(7)
      ..write(obj.strapType)
      ..writeByte(8)
      ..write(obj.glassMaterial);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WatchModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

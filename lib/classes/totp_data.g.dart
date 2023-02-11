// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'totp_data.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TotpDataAdapter extends TypeAdapter<TotpData> {
  @override
  final int typeId = 0;

  @override
  TotpData read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TotpData(
      id: fields[0] as String,
      label: fields[5] as String?,
      secret: fields[6] as String?,
      algorithm: fields[1] as Algorithm,
      digits: fields[2] as int,
      period: fields[3] as String,
      issuer: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, TotpData obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.algorithm)
      ..writeByte(2)
      ..write(obj.digits)
      ..writeByte(3)
      ..write(obj.period)
      ..writeByte(4)
      ..write(obj.issuer)
      ..writeByte(5)
      ..write(obj.label)
      ..writeByte(6)
      ..write(obj.secret);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TotpDataAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

import 'package:authenticator/common/classes/enums.dart';
import 'package:authenticator/common/classes/extensions.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class AlgorithmAdapter extends TypeAdapter<Algorithm> {
  @override
  final typeId = 2;

  @override
  void write(BinaryWriter writer, Algorithm obj) =>
      writer.writeString(obj.crypto);

  @override
  Algorithm read(BinaryReader reader) => Algorithm.from(reader.readString());
}

class OffsetAdapter extends TypeAdapter<Offset> {
  @override
  final typeId = 4;

  @override
  void write(BinaryWriter writer, Offset obj) =>
      writer.writeString(obj.parse());

  @override
  Offset read(BinaryReader reader) {
    return reader.readString().toOffset();
  }
}

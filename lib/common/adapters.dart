import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/common/enums.dart';
import 'package:authenticator/common/extensions.dart';
import 'package:objectid/objectid.dart';

class AlgorithmAdapter extends TypeAdapter<Algorithm> {
  @override
  final typeId = 2;

  @override
  void write(BinaryWriter writer, Algorithm obj) =>
      writer.writeString(obj.crypto);

  @override
  Algorithm read(BinaryReader reader) => Algorithm.from(reader.readString());
}

class ObjectIdAdapter extends TypeAdapter<ObjectId> {
  @override
  final typeId = 3;

  @override
  void write(BinaryWriter writer, ObjectId obj) =>
      writer.writeString(obj.hexString);

  @override
  ObjectId read(BinaryReader reader) =>
      ObjectId.fromHexString(reader.readString());
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

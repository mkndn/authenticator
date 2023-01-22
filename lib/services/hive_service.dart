import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:authenticator/classes/totp_data.dart';
import 'package:objectid/objectid.dart';

class HiveService {
  final Box<TotpData> _box = Hive.box<TotpData>('totp_data');
  final ValueNotifier<TotpData?> notifier = ValueNotifier(null);

  HiveService._();

  factory HiveService.instance() {
    return HiveService._();
  }

  Box<TotpData> getBox() => _box;

  void addItem(TotpData data) {
    _box.put(data.id.hexString, data);
  }

  TotpData? getItem(String itemId) => _box.get(itemId);

  void removeItem(ObjectId key) => _box.delete(key.hexString);

  void removeItemByKey(String key) => _box.delete(key);

  void removeItems(List<ObjectId> keys) =>
      _box.deleteAll(keys.map((k) => k.hexString));

  List<TotpData> getAllItems() => _box.values.toList();

  void reset() {
    _box.deleteAll(_box.keys);
    _box.clear();
  }
}

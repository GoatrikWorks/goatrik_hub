import 'package:hive_flutter/hive_flutter.dart';

class HiveStorage {
  static Future<void> init() async {
    await Hive.initFlutter();
    // Registrera eventuella adapters här, t.ex.:
    // Hive.registerAdapter(UserAdapter());
  }

  static Future<Box> openBox(String boxName) async {
    return await Hive.openBox(boxName);
  }

  static Box getBox(String boxName) {
    return Hive.box(boxName);
  }

  static Future<void> closeBox(String boxName) async {
    await Hive.box(boxName).close();
  }

  static Future<void> clearBox(String boxName) async {
    await Hive.box(boxName).clear();
  }
}

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LocalStorage {
  static Future save(String code, String value) async {
    const storage = FlutterSecureStorage();
    await storage.write(key: code, value: value);

    return;
  }

  static Future<String> readNum(String code) async {
    const storage = FlutterSecureStorage();
    var value = (await storage.read(key: code));
    if (value is String) {
      return value;
    } else {
      return "0";
    }
  }
  static Future<String> readString(String code) async {
    const storage = FlutterSecureStorage();
    var value = (await storage.read(key: code));
    if (value is String) {
      return value;
    } else {
      return "";
    }
  }

  static Future delete(String code) async {
    const storage = FlutterSecureStorage();
    await storage.delete(key: code);

    return;
  }

  static Future deleteAll() async {
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    return;
  }
}

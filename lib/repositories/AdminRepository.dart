import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:glive/database/appDatabase.dart';
import 'package:glive/database/repository.dart';
import 'package:glive/models/database/AdminModel.dart';
import 'package:sqflite/sqflite.dart';

class AdminRepository {
  static String tableName = "admins";

  //Important: This model is used to create tables in SQLITE
  static AdminModel model = AdminModel(
    id: "",
    firstName: "",
    lastName: "",
    username: "",
    password: "",
    permissions: "", //1,2,3
    userType: "",
    fundsId: "",
    createdAt: "",
    parentId: "",
    syncedAt: "",
    deletedAt: "",
  );

  static Future create(AdminModel obj) async {
    Completer completer = Completer();
    List cols = [];
    List vals = [];

    obj.toJson().forEach((key, value) {
      cols.add(key);
      if (value.runtimeType == String) {
        value = jsonEncode(value);
      }
      vals.add(replaceSingleQuotes(value));
    });

    String columns = cols.join(", ");
    String values = vals.join(", ");

    AppDatabase.database.transaction((txn) async {
      int id1 = await txn.rawInsert(
          sanitizeQuery("INSERT INTO $tableName($columns) VALUES($values)"));
      completer.complete(id1);
    });

    return completer.future;
  }

  static Future update(AdminModel obj) async {
    Completer completer = Completer();

    AdminModel? current = await get(obj.id);

    if (current != null) {
      List q = [];

      obj.toJson().forEach((key, value) {
        if (value.runtimeType == String) {
          value = jsonEncode(value);
        }
        q.add("$key = ${replaceSingleQuotes(value)}");
      });

      String query = q.join(", ");

      await AppDatabase.database.rawUpdate(
          sanitizeQuery("UPDATE $tableName SET $query WHERE id = '${obj.id}'"));

      completer.complete(true);
    } else {
      completer.complete(false);
    }

    return completer.future;
  }

  static Future save(AdminModel obj) async {
    Completer completer = Completer();

    AdminModel? current = await get(obj.id);

    if (current != null) {
      List q = [];

      obj.toJson().forEach((key, value) {
        if (value.runtimeType == String) {
          value = jsonEncode(value);
        }
        q.add("$key = ${replaceSingleQuotes(value)}");
      });

      String query = q.join(", ");

      await AppDatabase.database.rawUpdate(
          sanitizeQuery("UPDATE $tableName SET $query WHERE id = '${obj.id}'"));
      completer.complete("updated");
    } else {
      await create(obj);
      completer.complete("created");
    }

    return completer.future;
  }

  static Future delete(String id) async {
    Completer completer = Completer();

    AdminModel? current = await get(id);

    if (current != null) {
      await AppDatabase.database.rawUpdate(sanitizeQuery(
          "UPDATE $tableName SET deletedAt = '${DateTime.now().toIso8601String()}', syncedAt = '' WHERE id = '$id'"));

      completer.complete("deleted");
    } else {
      completer.complete("not found");
    }
    return completer.future;
  }

  static Future deleteAll() async {
    Completer completer = Completer();

    await AppDatabase.database.rawUpdate(sanitizeQuery(
        "UPDATE $tableName SET deletedAt = '${DateTime.now().toIso8601String()}', syncedAt = ''"));

    completer.complete("deleted all");

    return completer.future;
  }

  static Future<AdminModel?> get(String id) async {
    List<Map<String, Object?>> records = await AppDatabase.database
        .rawQuery(sanitizeQuery("SELECT * FROM $tableName WHERE id = '$id'"));

    if (records.isNotEmpty) {
      return AdminModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<AdminModel?> getIfNotDeleted(String id) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE id = '$id' AND (deletedAt IS NULL OR deletedAt = '')"));

    if (records.isNotEmpty) {
      return AdminModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<List<AdminModel>> getAll() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') ORDER BY createdAt DESC");
    List<AdminModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(AdminModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<AdminModel>> getAllDirectBranch() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') AND (parentId = 'super-admin' OR userType = 'super-admin') ORDER BY createdAt DESC");
    List<AdminModel> data = [];
    //log("Getting all direct branch: ${records.length}");
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(AdminModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<AdminModel>> getAllDirectChildren(String adminId) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') AND parentId = '$adminId' ORDER BY createdAt DESC"));
    List<AdminModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(AdminModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<AdminModel>> getChildren(String adminId) async {
    List<Map<String, Object?>> myChildrenQuery = await AppDatabase.database
        .rawQuery(sanitizeQuery(
            "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') AND parentId = '$adminId' ORDER BY createdAt DESC"));

    List<AdminModel> myChildren = [];
    if (myChildrenQuery.isNotEmpty) {
      for (var child in myChildrenQuery) {
        myChildren.add(AdminModel.fromJson(child));
      }
    }

    List<AdminModel> myGrandChildren = [];

    for (AdminModel child in myChildren) {
      myGrandChildren = [...myGrandChildren, ...(await getChildren(child.id))];
    }

    return [...myChildren, ...myGrandChildren];
  }

  static Future<List<AdminModel>> getParents(String adminId) async {
    AdminModel? myModel = await get(adminId);

    if (myModel != null) {
      List<Map<String, Object?>> myParentsQuery = await AppDatabase.database
          .rawQuery(sanitizeQuery(
              "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') AND id = '${myModel.parentId}'"));

      //Transforming to AdminModel
      List<AdminModel> myParents = [];
      if (myParentsQuery.isNotEmpty) {
        for (var child in myParentsQuery) {
          myParents.add(AdminModel.fromJson(child));
        }
      }

      List<AdminModel> myGrandParents = [];

      for (AdminModel child in myParents) {
        myGrandParents = [...myGrandParents, ...(await getParents(child.id))];
      }

      return [...myParents, ...myGrandParents];
    } else {
      return [];
    }
  }

  static Future<List<AdminModel>> getAllByDateRange(
      String startDate, String endDate) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE date(substr(createdAt, 1, 10)) BETWEEN '$startDate' AND '$endDate'"));
    List<AdminModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(AdminModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<AdminModel>> getUnsynced() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        sanitizeQuery(
            "SELECT * FROM $tableName WHERE syncedAt IS NULL OR syncedAt = '';"));
    List<AdminModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(AdminModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<AdminModel?> getByUsername(String username) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE username = '$username' AND (deletedAt IS NULL OR deletedAt = '')"));

    if (records.isNotEmpty) {
      return AdminModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static String sanitizeQuery(String query) {
    return query;
  }

  static String replaceSingleQuotes(String input) {
    String res = "'${input.replaceAll("'", "''")}'";
    res = res.replaceAll("'\"", "'");
    res = res.replaceAll("\"'", "'");
    return res;
  }

  static Repository repository = Repository(tableName: tableName, model: model);
}

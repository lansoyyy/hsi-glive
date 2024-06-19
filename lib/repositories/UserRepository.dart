import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:glive/models/database/AdminModel.dart';
import 'package:glive/models/database/UserModel.dart';
import 'package:glive/repositories/adminRepository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:glive/database/appDatabase.dart';
import 'package:glive/database/repository.dart';

class UserRepository {
  static String tableName = "users";

  //Important: This model is used to create tables in SQLITE
  static UserModel model = UserModel(
    id: "",
    adminId: "",
    firstName: "",
    lastName: "",
    middleName: "",
    address: "",
    birthDate: "",
    mobile: "",
    gender: "",
    image: "",
    imageName: "",
    createdAt: "",
    syncedAt: "",
    deletedAt: "",
    precint: "",
  );

  static Future create(UserModel obj) async {
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

  static Future update(UserModel obj) async {
    Completer completer = Completer();

    UserModel? current = await get(obj.id);

    if (current != null) {
      List q = [];

      obj.toJson().forEach((key, value) {
        if (value.runtimeType == String) {
          value = jsonEncode(value);
        }
        q.add("$key = ${replaceSingleQuotes(value)}");
      });

      String query = q.join(", ");

      String sqlQuery = "UPDATE $tableName SET $query WHERE id = '${obj.id}'";

      await AppDatabase.database.rawUpdate(sanitizeQuery(sqlQuery));

      completer.complete(true);
    } else {
      completer.complete(false);
    }

    return completer.future;
  }

  static Future save(UserModel obj) async {
    Completer completer = Completer();

    UserModel? current = await get(obj.id);

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

    UserModel? current = await get(id);

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

  static Future<UserModel?> get(String id) async {
    List<Map<String, Object?>> records = await AppDatabase.database
        .rawQuery(sanitizeQuery("SELECT * FROM $tableName WHERE id = '$id'"));

    if (records.isNotEmpty) {
      return UserModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<UserModel?> getIfNotDeleted(String id) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE id = '$id' AND (deletedAt IS NULL OR deletedAt = '')"));

    if (records.isNotEmpty) {
      return UserModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<List<UserModel>> getAll() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        "SELECT * FROM $tableName WHERE deletedAt IS NULL OR deletedAt = '' ORDER BY createdAt DESC");
    List<UserModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(UserModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<UserModel>> getAllFromRoot(String leafAdminId) async {
    AdminModel? adminModel = await AdminRepository.get(leafAdminId);
    if (adminModel != null) {
      List<AdminModel> parentAdmins = [];
      List<AdminModel> childAdmins = [];

      List<String> childAdminsId = [];
      /* 
      List<AdminModel> parentAdmins =
          await AdminRepository.getParents(leafAdminId);
      List<AdminModel> childAdmins =
          await AdminRepository.getChildren(leafAdminId); 
          
      List<String> parentAdminsId = parentAdmins.map((e) => e.id).toList();
      parentAdminsId.add(leafAdminId);
      parentAdminsId = [...childAdminsId, ...parentAdminsId];
          */

      if (adminModel.parentId == "super-admin") {
        childAdmins = await AdminRepository.getChildren(leafAdminId);
        childAdminsId = childAdmins.map((e) => e.id).toList();
        childAdminsId.add(leafAdminId);
      } else {
        parentAdmins = await AdminRepository.getParents(leafAdminId);
        for (int i = 0; i < parentAdmins.length; i++) {
          AdminModel parentAdmin = parentAdmins[i];
          if (parentAdmin.parentId == "super-admin") {
            childAdmins = await AdminRepository.getChildren(parentAdmin.id);
            childAdminsId = childAdmins.map((e) => e.id).toList();
            childAdminsId.add(parentAdmin.id);
            break;
          }
        }
      }

      List<String> uniqueList = childAdminsId.toSet().toList();

      String addToQuery = "";

      if (uniqueList.isNotEmpty) {
        addToQuery += "AND (";
      }

      for (int i = 0; i < uniqueList.length; i++) {
        String adminId = uniqueList[i];
        addToQuery += "${i == 0 ? "" : " OR "}adminId = '$adminId'";
      }

      if (uniqueList.isNotEmpty) {
        addToQuery += ")";
      }

      String sqlQuery =
          "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') $addToQuery ORDER BY createdAt DESC";

      List<Map<String, Object?>> records =
          await AppDatabase.database.rawQuery(sqlQuery);

      List<UserModel> data = [];
      if (records.isNotEmpty) {
        for (var record in records) {
          data.add(UserModel.fromJson(record));
        }
        return data;
      } else {
        return [];
      }
    } else {
      return [];
    }
  }

/* 
  static Future<List<UserModel>> getAllFromRoot(String leafAdminId) async {
    List<AdminModel> parentAdmins =
        await AdminRepository.getParents(leafAdminId);
    List<AdminModel> childAdmins =
        await AdminRepository.getChildren(leafAdminId);
    List<String> childAdminsId = childAdmins.map((e) => e.id).toList();
    List<String> parentAdminsId = parentAdmins.map((e) => e.id).toList();
    parentAdminsId.add(leafAdminId);
    parentAdminsId = [...childAdminsId, ...parentAdminsId];

    List<String> uniqueList = parentAdminsId.toSet().toList();

    String addToQuery = "";

    if (uniqueList.isNotEmpty) {
      addToQuery += "AND (";
    }

    for (int i = 0; i < uniqueList.length; i++) {
      String adminId = uniqueList[i];
      addToQuery += "${i == 0 ? "" : " OR "}adminId = '${adminId}'";
    }

    if (uniqueList.isNotEmpty) {
      addToQuery += ")";
    }

    String sqlQuery =
        "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') ${addToQuery} ORDER BY createdAt DESC";

    log("Unique List: ${uniqueList.length}");

    log("Query: ${sqlQuery}");

    List<Map<String, Object?>> records =
        await AppDatabase.database.rawQuery(sqlQuery);

    List<UserModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(UserModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }
 */

  static Future<List<UserModel>> getAllByDateRange(
      String startDate, String endDate) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE date(substr(createdAt, 1, 10)) BETWEEN '$startDate' AND '$endDate'"));
    List<UserModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(UserModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<UserModel>> getUnsynced() async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE (syncedAt IS NULL OR syncedAt = '');"));
    List<UserModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(UserModel.fromJson(record));
      }
      return data;
    } else {
      return [];
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

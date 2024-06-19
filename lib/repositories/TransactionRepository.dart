import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:glive/models/database/TransactionModel.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:glive/database/appDatabase.dart';
import 'package:glive/database/repository.dart';

class TransactionRepository {
  static String tableName = "transactions";

  //Important: This model is used to create tables in SQLITE
  static TransactionModel model = TransactionModel(
    id: "",
    adminId: "",
    userId: "",
    fundsId: "",
    createdAt: "",
    amount: "",
    reason: "",
    status: "",
    metadata: "",
    proof: "",
    name: "",
    precint: "",
    syncedAt: "",
    deletedAt: "",
  );

  static Future create(TransactionModel obj) async {
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

  static Future update(TransactionModel obj) async {
    Completer completer = Completer();

    TransactionModel? current = await get(obj.id);

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

  static Future save(TransactionModel obj) async {
    Completer completer = Completer();

    TransactionModel? current = await get(obj.id);

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

    TransactionModel? current = await get(id);

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

  static Future<TransactionModel?> get(String id) async {
    List<Map<String, Object?>> records = await AppDatabase.database
        .rawQuery(sanitizeQuery("SELECT * FROM $tableName WHERE id = '$id'"));

    if (records.isNotEmpty) {
      return TransactionModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<TransactionModel?> getIfNotDeleted(String id) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE id = '$id' AND (deletedAt IS NULL OR deletedAt = '')"));

    if (records.isNotEmpty) {
      return TransactionModel.fromJson(records.first);
    } else {
      return null;
    }
  }

  static Future<List<TransactionModel>> getAll() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        "SELECT * FROM $tableName WHERE deletedAt IS NULL OR deletedAt = '' ORDER BY createdAt DESC");
    List<TransactionModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<TransactionModel>> getAllByFundId(String fundsId) async {
    List<
        Map<String,
            Object?>> records = await AppDatabase.database.rawQuery(sanitizeQuery(
        "SELECT * FROM $tableName WHERE (deletedAt IS NULL OR deletedAt = '') AND fundsId = '$fundsId'  ORDER BY createdAt DESC"));
    List<TransactionModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<TransactionModel>> getAllByDateRange(
      String fundsId, String startDate, String endDate) async {
    if (fundsId.isEmpty && !isSuperAdmin()) {
      return [];
    }
    String myQuery = sanitizeQuery(
        "SELECT * FROM $tableName WHERE date(substr(createdAt, 1, 10)) BETWEEN '$startDate' AND '$endDate' AND fundsId = '$fundsId'");
    if (isSuperAdmin()) {
      myQuery = sanitizeQuery(
          "SELECT * FROM $tableName WHERE date(substr(createdAt, 1, 10)) BETWEEN '$startDate' AND '$endDate'");
    }
    List<Map<String, Object?>> records =
        await AppDatabase.database.rawQuery(myQuery);
    List<TransactionModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<List<TransactionModel>> getAllByUserId(String userId) async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        sanitizeQuery("SELECT * FROM $tableName WHERE userId = '$userId'"));

    List<TransactionModel> data = [];

    log("Record: $records");
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data.reversed.toList();
    } else {
      return [];
    }
  }

  static Future<List<TransactionModel>> getAllByAdminId(String adminId) async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        sanitizeQuery("SELECT * FROM $tableName WHERE adminId = '$adminId'"));

    List<TransactionModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data.reversed.toList();
    } else {
      return [];
    }
  }

  static Future<List<TransactionModel>> getUnsynced() async {
    List<Map<String, Object?>> records = await AppDatabase.database.rawQuery(
        sanitizeQuery(
            "SELECT * FROM $tableName WHERE syncedAt IS NULL OR syncedAt = '';"));
    List<TransactionModel> data = [];
    if (records.isNotEmpty) {
      for (var record in records) {
        data.add(TransactionModel.fromJson(record));
      }
      return data;
    } else {
      return [];
    }
  }

  static Future<TransactionModel?> getLatest(String userId) async {
    List<TransactionModel> all = await getAllByUserId(userId);
    if (all.isNotEmpty) {
      return all.first;
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

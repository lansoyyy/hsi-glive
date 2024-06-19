import 'dart:async';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:glive/constants/StorageCodes.dart';
import 'package:path_provider/path_provider.dart';
import 'package:glive/repositories/adminRepository.dart';
import 'package:glive/repositories/fundRepository.dart';
import 'package:glive/repositories/transactionRepository.dart';
import 'package:glive/repositories/userRepository.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'package:glive/database/repository.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:glive/utils/localStorage.dart';

import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'dart:io' as io;
import 'package:path/path.dart' as p;

class AppDatabase {
  //static String databaseName = "child_admin_db.db";
  static String databaseName = "";
  static late Database database;
  static bool didInititate = false;

  static List<Repository> repositories = [
    AdminRepository.repository,
    FundRepository.repository,
    TransactionRepository.repository,
    UserRepository.repository
  ];

  static Future initiate() async {
    //await reset();
    Completer completer = Completer();

    String installationId =
        await LocalStorage.readString(StorageCodes.installationId);

    log("Installation ID: '$installationId'");

    if (installationId.isEmpty) {
      installationId = uid();
      await LocalStorage.save(StorageCodes.installationId, installationId);
    }

    databaseName = "$installationId.db";

    String didInit = await LocalStorage.readString(StorageCodes.didInit);
    print("didInit: '$didInit' $databaseName");
    if (kIsWeb) {
      if (!didInititate) {
        var db = await databaseFactory.openDatabase(
          databaseName,
        );
        database = db;

        if (didInit != "true") {
          for (var repository in repositories) {
            Map fields = getFields(repository);

            String types = "";
            fields.forEach((key, value) {
              types += "${"${" " + key} " + value},";
            });
            types = types.substring(0, types.lastIndexOf(","));

            String query = "CREATE TABLE ${repository.tableName} ($types )";
            try {
              await db.execute(query);
            } catch (_) {}
          }

          await LocalStorage.save(StorageCodes.didInit, "true");
          log("Web Database Initiated: $installationId.db");
        }
      }
      didInititate = true;
      completer.complete();
    } else {
      if (Platform.isWindows || Platform.isLinux) {
        if (!didInititate) {
          databaseFactory = databaseFactoryFfi;
          final io.Directory appDocumentsDir =
              await getApplicationDocumentsDirectory();

          //Create path for database
          String dbPath =
              p.join(appDocumentsDir.path, "palengkeproject", databaseName);

          var db = await databaseFactory.openDatabase(
            dbPath,
          );
          database = db;

          if (didInit != "true") {
            for (var repository in repositories) {
              Map fields = getFields(repository);

              String types = "";
              fields.forEach((key, value) {
                types += "${"${" " + key} " + value},";
              });
              types = types.substring(0, types.lastIndexOf(","));

              String query = "CREATE TABLE ${repository.tableName} ($types )";
              try {
                await db.execute(query);
              } catch (_) {}
            }

            await LocalStorage.save(StorageCodes.didInit, "true");
            log("Windows Database Initiated: $installationId.db");
          }
        }
        didInititate = true;
        completer.complete();
      } else {
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, databaseName);
        database = await openDatabase(path, version: 1,
            onCreate: (Database db, int version) async {
          for (var repository in repositories) {
            Map fields = getFields(repository);

            String types = "";
            fields.forEach((key, value) {
              types += "${"${" " + key} " + value},";
            });
            types = types.substring(0, types.lastIndexOf(","));

            String query = "CREATE TABLE ${repository.tableName} ($types )";
            try {
              await db.execute(query);
            } catch (_) {}
          }
        });
        didInititate = true;
        log("Mobile Database Initiated: $installationId.db");
        completer.complete();
      }
    }

    return completer.future;
  }

  static Map getFields(Repository repository) {
    Map map = repository.model.toJson();
    Map newMap = map.map(
      (key, value) {
        String type = "";
        if (value.runtimeType == String) {
          type = "TEXT";
        } else if (value.runtimeType == int) {
          type = "INTEGER";
        } else if (value.runtimeType == double) {
          type = "REAL";
        } else {
          type = "TEXT";
        }

        return MapEntry(key, type);
      },
    );
    return newMap;
  }

  static Future<void> reset() async {
    if (kIsWeb) {
      //Create path for
      await databaseFactory.deleteDatabase(
          "${await LocalStorage.readString(StorageCodes.installationId)}.db");
      log("Web database deleted");
    } else {
      if (Platform.isWindows || Platform.isLinux) {
        databaseFactory = databaseFactoryFfi;
        final io.Directory appDocumentsDir =
            await getApplicationDocumentsDirectory();

        //Create path for database
        String dbPath =
            p.join(appDocumentsDir.path, "palengkeproject", databaseName);
        databaseFactory.deleteDatabase(dbPath);
      } else {
        var databasesPath = await getDatabasesPath();
        String path = join(databasesPath, databaseName);
        await deleteDatabase(path);
      }
    }
    didInititate = false;
    await LocalStorage.save(StorageCodes.installationId, uid());
    await LocalStorage.save(StorageCodes.didInit, "false");

    try {
      if (database.isOpen) {
        await database.close();
        await initiate();
      }
    } catch (_) {}

    return;
  }

  static Future<void> closeDatabase() async {
    if (didInititate) {
      await database.close();
      didInititate = false;
    }

    return;
  }
}

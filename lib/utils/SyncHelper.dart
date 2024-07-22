// ignore_for_file: file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:glive/constants/StorageCodes.dart';
import 'package:glive/database/appDatabase.dart';
import 'package:glive/models/database/AdminModel.dart';
import 'package:glive/models/database/FundModel.dart';
import 'package:glive/models/database/TransactionModel.dart';
import 'package:glive/models/database/UserModel.dart';
import 'package:glive/models/response/UnsyncedResponse.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:glive/network/NetworkProvider.dart';
import 'package:glive/repositories/AdminRepository.dart';
import 'package:glive/repositories/fundRepository.dart';
import 'package:glive/repositories/TransactionRepository.dart';
import 'package:glive/repositories/UserRepository.dart';
import 'package:glive/utils/commonFunctions.dart';
import 'package:glive/utils/globalVariables.dart';

import 'localStorage.dart';

class SyncHelper {
  static NetworkProvider networkProvider = NetworkProvider();

  //receive sync
  static Future checkSync() async {
    Completer completer = Completer();
    if (!AppDatabase.didInititate) {
      completer.complete(false);
      return completer.future;
    }
    log("Syncing Online to Offline data...");
    NetworkProvider networkProvider = NetworkProvider();
    String token = await LocalStorage.readString(StorageCodes.token);
    if (token.isEmpty) {
      return;
    }

    String myId = await LocalStorage.readString(StorageCodes.installationId);

    if (myId.isEmpty) {
      myId = uid();
      await LocalStorage.save(StorageCodes.installationId, myId);
    }
    // String myId = uid();
    String response = await networkProvider.get("${ApiEndpoints.unsynced}?installationId=$myId");

    if (response.isNotEmpty) {
      UnsyncedResponse unsyncedResponse = UnsyncedResponse.fromJson(jsonDecode(response));
      await Future.wait([syncAdmins(unsyncedResponse), syncFunds(unsyncedResponse), syncTransactions(unsyncedResponse), syncUsers(unsyncedResponse)]);
    }

    completer.complete(false);

    return completer.future;
  }

  static Future syncUsers(UnsyncedResponse unsyncedResponse) async {
    Completer completer = Completer();

    for (UserModel model in unsyncedResponse.users!) {
      model.syncedAt = DateTime.now().toIso8601String();
      await UserRepository.save(model);
    }

    completer.complete();

    return completer.future;
  }

  static Future syncTransactions(UnsyncedResponse unsyncedResponse) async {
    Completer completer = Completer();

    for (TransactionModel model in unsyncedResponse.transactions!) {
      model.syncedAt = DateTime.now().toIso8601String();
      await TransactionRepository.save(model);
    }
    completer.complete();

    return completer.future;
  }

  static Future syncFunds(UnsyncedResponse unsyncedResponse) async {
    Completer completer = Completer();

    for (FundModel model in unsyncedResponse.funds!) {
      model.syncedAt = DateTime.now().toIso8601String();
      await FundRepository.save(model);
    }
    completer.complete();

    return completer.future;
  }

  static Future syncAdmins(UnsyncedResponse unsyncedResponse) async {
    Completer completer = Completer();

    for (AdminModel model in unsyncedResponse.admins!) {
      model.syncedAt = DateTime.now().toIso8601String();
      await AdminRepository.save(model);
      if (model.id == GlobalVariables.currentUser.id) {
        GlobalVariables.currentUser = model;
        await LocalStorage.save(StorageCodes.currentUser, jsonEncode(model.toJson()));
      }
    }

    completer.complete();

    return completer.future;
  }

  static Future syncAllUnsynced() async {
    log("Syncing Offline to Online data...");
    if (!AppDatabase.didInititate) {
      return;
    }
    String token = await LocalStorage.readString(StorageCodes.token);
    if (token.isEmpty) {
      return;
    }
    String myId = await LocalStorage.readString(StorageCodes.installationId);
    if (myId.isNotEmpty) {
      await Future.wait([
        unsyncedFunds(myId),
        unsyncedAdmins(myId),
        unsyncedUsers(myId),
        unsyncedTransactions(myId),
      ]);
    }
  }

  static Future unsyncedFunds(String installationId) async {
    List<FundModel> unsynced = await FundRepository.getUnsynced();
    for (FundModel model in unsynced) {
      Map data = model.toJson();
      if (data["deletedAt"].isEmpty) {
        data.remove("deletedAt");
      }

      // log("Data: ${data}");
      String response = await networkProvider.post("${ApiEndpoints.saveFund}?installationId=$installationId", body: data);
      if (response.isNotEmpty) {
        model.syncedAt = DateTime.now().toIso8601String();
        await FundRepository.update(model);
      }
    }
  }

  static Future unsyncedAdmins(String installationId) async {
    List<AdminModel> unsynced = await AdminRepository.getUnsynced();

    for (AdminModel model in unsynced) {
      Map data = model.toJson();
      if (data["deletedAt"].isEmpty) {
        data.remove("deletedAt");
      }

      String response = await networkProvider.post("${ApiEndpoints.saveAdmin}?installationId=$installationId", body: data);
      if (response.isNotEmpty) {
        model.syncedAt = DateTime.now().toIso8601String();
        if (model.id == GlobalVariables.currentUser.id) {
          GlobalVariables.currentUser = model;
          await LocalStorage.save(StorageCodes.currentUser, jsonEncode(model.toJson()));
        }
        await AdminRepository.update(model);
      }
    }
  }

  static Future unsyncedUsers(String installationId) async {
    List<UserModel> unsynced = await UserRepository.getUnsynced();

    for (UserModel model in unsynced) {
      Map data = model.toJson();
      if (data["deletedAt"].isEmpty) {
        data.remove("deletedAt");
      }
      String response = await networkProvider.post("${ApiEndpoints.saveUser}?installationId=$installationId", body: data);
      if (response.isNotEmpty) {
        model.syncedAt = DateTime.now().toIso8601String();
        await UserRepository.update(model);
      }
    }
  }

  static Future unsyncedTransactions(String installationId) async {
    List<TransactionModel> unsynced = await TransactionRepository.getUnsynced();

    for (TransactionModel model in unsynced) {
      Map data = model.toJson();
      if (data["deletedAt"].isEmpty) {
        data.remove("deletedAt");
      }
      String response = await networkProvider.post("${ApiEndpoints.saveTransaction}?installationId=$installationId", body: data);
      if (response.isNotEmpty) {
        model.syncedAt = DateTime.now().toIso8601String();
        await TransactionRepository.update(model);
      }
    }
  }
}

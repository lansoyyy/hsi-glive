// ignore_for_file: unused_catch_clause, non_constant_identifier_names, file_names

import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:glive/utils/CallbackModel.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class RealtimeSignalling {
  static List<CallbackModel> signalFunctions = [];
  static late WebSocketChannel channel;
  static String initId = "";
  static String myClientId = "";
  static String openType = "";

  static void signal(List item) {
    log("signal: ${signalFunctions.length}");
    for (var cb in signalFunctions) {
      cb.callback(item);
    }
  }

  static String Type_Funds = "funds";
  static String Type_Users = "users";
  static String Type_Admins = "admins";
  static String Type_Transactions = "transactions";

  static void onSignal(CallbackModel cb) {
    signalFunctions = signalFunctions.where((el) => el.id != cb.id).toList()..add(cb);
  }

  static Future restart() async {
    if (initId.isNotEmpty && myClientId.isNotEmpty) {
      await init(initId, myClientId);
    }
  }

  static Future init(String userId, String clientId) async {
    log("Socket init: $userId");
    openType = "home";
    initId = userId;
    myClientId = clientId;
    Completer completer = Completer();
    Uri uri = Uri.parse('wss://ws.qrproject.ksmiguel.com');
    channel = WebSocketChannel.connect(uri);
    try {
      await channel.ready;
      register(userId, clientId);

      channel.stream.listen(
        (message) {
          log("Message received: $message");
          onReceive(jsonDecode(message));
        },
        onDone: () {
          log("Disconnected");
          Future.delayed(const Duration(milliseconds: 1000), () async {
            try {
              if (openType != "closed") {
                await init(userId, clientId);
              }
            } catch (_) {
              Future.delayed(const Duration(milliseconds: 1000), () async {
                if (openType != "closed") {
                  await init(userId, clientId);
                }
              });
            }
          });
        },
        onError: (err) {
          log("Error");
          Future.delayed(const Duration(milliseconds: 1000), () async {
            try {
              if (openType != "closed") {
                await init(userId, clientId);
              }
            } catch (_) {
              Future.delayed(const Duration(milliseconds: 1000), () async {
                if (openType != "closed") {
                  await init(userId, clientId);
                }
              });
            }
          });
        },
      );

/*       await SyncHelper.checkSync();
      await SyncHelper.syncAllUnsynced();
      GlobalControllers.mainController.internet(); */
      completer.complete();
    } on SocketException catch (e) {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        try {
          if (openType != "closed") {
            await init(userId, clientId);
          }
        } catch (_) {
          Future.delayed(const Duration(milliseconds: 1000), () async {
            if (openType != "closed") {
              await init(userId, clientId);
            }
          });
        }
      });
    } on WebSocketChannelException catch (e) {
      Future.delayed(const Duration(milliseconds: 1000), () async {
        try {
          if (openType != "closed") {
            await init(userId, clientId);
          }
        } catch (_) {
          Future.delayed(const Duration(milliseconds: 1000), () async {
            if (openType != "closed") {
              await init(userId, clientId);
            }
          });
        }
      });
    }

    return completer.future;
  }

  static void onReceive(Map data) async {
    String type = data["type"];
    if (data["clientId"] != myClientId) {
      // await SyncHelper.checkSync();
      signal([type, data]);
    }
  }

  static void register(String userId, String clientId) {
    log("Socket connected: $userId");
    Map<String, String> data = {"type": "register", "userId": userId, "clientId": clientId};
    channel.sink.add(jsonEncode(data));
  }

  static void sendToUserId(String userId, String message) async {
    if (channel.closeCode != null) {
      await channel.ready;
    }

    // sendMessage(GlobalVariables.adminData.id.toString(), userId, message);
  }

  static void sendMessage(String from, String to, String message) {
    Map<String, String> data = {"type": "message", "from": from, "to": to, "message": message};
    channel.sink.add(jsonEncode(data));
  }

  static void sendType(String type) {
    log("Type sent: $type $myClientId $initId");
    Map<String, String> data = {"type": type, "clientId": myClientId, "userId": initId};
    channel.sink.add(jsonEncode(data));
  }

  static void send(Map<String, dynamic> data) async {
    if (channel.closeCode != null) {
      await channel.ready;
    }
    channel.sink.add(jsonEncode(data));
  }

  static void exit() {
    initId = "";
    myClientId = "";
    openType = "closed";
    try {
      channel.sink.close();
    } catch (_) {}
  }
}

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:glive/utils/CallbackModel.dart';

class MainController extends ChangeNotifier {
  List<CallbackModel> internetFunctions = [];

  void internet() {
    for (var cb in internetFunctions) {
      cb.callback("");
    }
  }

  void onInternet(CallbackModel cb) {
    internetFunctions = internetFunctions.where((el) => el.id != cb.id).toList()
      ..add(cb);
  }
}

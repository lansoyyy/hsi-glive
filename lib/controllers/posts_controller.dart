import 'dart:developer';

import 'package:get/get.dart';
import 'package:glive/network/ApiImplementation.dart';
import 'package:glive/utils/ToastHelper.dart';

class PostsController extends GetxController {
  static ApiImplementation apiImplementation = ApiImplementation();

  Future<void> likePosts({required String postId}) async {
    try {
      var response = await apiImplementation.likePosts(postId);

      if (response.contains("Successfully like post")) {
        ToastHelper.success(response);
        update();
      } else {
        ToastHelper.error(response);
      }
    } catch (ex) {
      log("Something went wrong!like posts ${ex.toString()}");
    }
  }

  Future<void> unlikePosts({required String postId}) async {
    try {
      var response = await apiImplementation.unlikePosts(postId);

      if (response.contains("Successfully unlike post")) {
        ToastHelper.success(response);
        update();
      } else {
        ToastHelper.error(response);
      }
    } catch (ex) {
      log("Something went wrong! unlike posts ${ex.toString()}");
    }
  }

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
  }
}

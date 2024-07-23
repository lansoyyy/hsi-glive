import 'dart:developer';

import 'package:get/get.dart';
import 'package:glive/controllers/audios_controller.dart';
import 'package:glive/controllers/posts_controller.dart';
import 'package:glive/models/response/InterestListResponse.dart';
import 'package:glive/network/ApiImplementation.dart';
import 'package:glive/network/NetworkProvider.dart';
import 'package:glive/utils/ToastHelper.dart';

class HomeController extends GetxController {
  NetworkProvider networkProvider = NetworkProvider();
  PostsController postsController = Get.put(PostsController());
  AudioController audioController = Get.put(AudioController());
  static ApiImplementation apiImplementation = ApiImplementation();
  final RxInt selectedIndex = 0.obs;

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

  Future<void> getInterestList() async {
    try {
      var response = await apiImplementation.getInterestList();
      if (response.c == 200 && response.d != null) {
        InterestListResponse interestListResponse = response.d!;
        log('InterestListResponse ${interestListResponse.list[0].interestModelId}');
      } else if (response.c == 401) {
        ToastHelper.error(response.m);
      } else {
        ToastHelper.error(response.m);
      }
    } catch (ex) {
      ToastHelper.error("Something went wrong!");
    }
  }
}

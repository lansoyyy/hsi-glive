import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideoLiveController extends GetxController {
  RxString selectedCategory = "".obs;
  late IconData icons = Icons.arrow_drop_down;
  RxBool isDropdownOpen = false.obs;
  RxInt selectedtedLive = 0.obs;
  RxInt multiLiveCounte = 4.obs;

  RxList<Map<String, dynamic>> categories = <Map<String, dynamic>>[].obs;
  RxList<Map<String, dynamic>> addCategories = <Map<String, dynamic>>[].obs;
  RxDouble multiLiveAspectRatio = 1.0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    initContentCategories();
  }

  void initContentCategories() {
    categories.value = [
      {'icon': Icons.pets, 'label': 'Animals'},
      {'icon': Icons.insert_emoticon, 'label': 'Comedy'},
      {'icon': Icons.card_travel, 'label': 'Travel'},
      {'icon': Icons.fastfood, 'label': 'Food'},
      {'icon': Icons.sports_soccer, 'label': 'Sports'},
      {'icon': Icons.brush, 'label': 'Beauty & Style'},
      {'icon': Icons.palette, 'label': 'Arts'},
      {'icon': Icons.videogame_asset, 'label': 'Gaming'},
    ];
  }
}

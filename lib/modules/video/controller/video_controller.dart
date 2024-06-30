// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:ffi';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/models/app/PostModel.dart';
import 'package:glive/modules/video/data/post_data.dart';

class VideoController extends GetxController {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();

  var isLoading = false.obs;
  RxBool isPostDataRefreshed = false.obs;

  final pageController2 = PageController().obs;
  CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
  var currentVideoIndex = 0.obs;

  var pauseVideoIndex = 0.obs;
  RxList<PostModel> postModelItems = <PostModel>[].obs;

  var isVideoPlaying = false.obs;
  var isVideoVisible = true.obs;

  RxInt selectedTabIndex = 2.obs;
  RxInt playCount = 0.obs;
  final videoPageController = PageController(initialPage: 2).obs;
  List<int> pages = <int>[].obs;
  RxInt tapCount = 0.obs;
  @override
  void onInit() {
    // TODO: implement onInit
    pageController2.value = PageController(initialPage: currentVideoIndex.value, viewportFraction: 1, keepPage: true);
    pageController2.value.addListener(_scrollListener);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController2.value.removeListener(_scrollListener);
    videoPageController.value.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (pageController2.value.position.pixels == pageController2.value.position.maxScrollExtent) {
      fetchMoreVideos();
    }
  }

  void initializeVideos() {
    postModelItems.addAll(initialPostData);
    pages.addAll(List.generate(postModelItems.length, (index) => index));
  }

  void fetchMoreVideos() async {
    if (isLoading.value) return;
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 1));
    postModelItems.addAll(getMorePostData);
    postModelItems.refresh();
    pages.addAll(List.generate(getMorePostData.length, (index) => pages.length + index));

    isLoading.value = false;
  }

  Future<void> onRefreshVideo() async {
    await Future.delayed(const Duration(seconds: 1)).then((value) {});
    postModelItems.clear();
    postModelItems.addAll(onRefreshPostData);
    postModelItems.refresh();
    pageController2.value
        .animateToPage(onRefreshPostData.indexOf(postModelItems.first), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    update();
    isPostDataRefreshed.value = true;
  }

  void handleBottomNavigationTap() {
    tapCount.value++;
    if (tapCount.value == 2 && currentVideoIndex.value != 0) {
      pageController2.value.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else if (tapCount.value >= 3) {
      tapCount.value = 0;
      triggerRefreshIndicator();
    }
  }

  void triggerRefreshIndicator() {
    refreshIndicatorKey.currentState?.show(atTop: true);
    if (pageController2.value.hasClients) {
      pageController2.value.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((_) => onRefreshVideo());
    }
  }

  void onTabSelected(int index) {
    selectedTabIndex.value = index;
    videoPageController.value.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (selectedTabIndex.value == 2) {
      cachedVideoPlayerPlusController?.play();
    }
  }

  void onPageChanged(int index) {
    selectedTabIndex.value = index;
  }
}

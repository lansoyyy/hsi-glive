// ignore_for_file: unused_import

import 'dart:developer';
import 'dart:ffi';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:glive/models/app/FollowedUserModel.dart';
import 'package:glive/models/app/FollowingModel.dart';
import 'package:glive/models/app/ForYouModel.dart';
import 'package:glive/models/app/PostModel.dart';
import 'package:glive/models/app/SuggestToFollowModel.dart';
import 'package:glive/models/response/FollowedUserResponse.dart';
import 'package:glive/models/response/PostsFollowingResponse.dart';
import 'package:glive/models/response/PostsForYouResponse.dart';
import 'package:glive/models/response/SuggestToFollowResponse.dart';
import 'package:glive/modules/video/data/post_data.dart';
import 'package:glive/network/ApiImplementation.dart';
import 'package:glive/utils/ToastHelper.dart';

class VideoController extends GetxController {
  final GlobalKey<RefreshIndicatorState> refreshIndicatorKey = GlobalKey();
  PostsForYouResponse? postsForYouResponse;
  PostsFollowingResponse? postsFollowingResponse;
  SuggestToFollowResponse? suggestToFollowResponse;
  FollowedUseeResponse? followedUseeResponse;
  RxList<ForYouModel> postsForYouData = <ForYouModel>[].obs;
  RxList<FollowingModel> postsFollowingData = <FollowingModel>[].obs;
  RxList<SuggestToFollowModel> suggestToFollowData = <SuggestToFollowModel>[].obs;
  RxList<String> followedUserData = <String>[].obs;

  static ApiImplementation apiImplementation = ApiImplementation();

  var isLoading = false.obs;
  RxBool isPostDataRefreshed = false.obs;
  RxBool isFollowedClicked = false.obs;

  final pageController1 = PageController().obs;
  final pageController2 = PageController().obs;
  final suggestedController = PageController().obs;
  RxDouble currentPage = 0.0.obs;

  CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
  var currentForYouIndex = 0.obs;
  var currentFollowingIndex = 0.obs;

  var pauseVideoIndex = 0.obs;
  // RxList<PostModel> postModelItems = <PostModel>[].obs;

  var isVideoPlaying = false.obs;
  var isVideoVisible = true.obs;

  RxInt selectedTabIndex = 1.obs;
  RxInt playCount = 0.obs;
  final videoPageController = PageController(initialPage: 1).obs;

  RxInt pageForYouCount = 1.obs;
  RxInt limitForYouCount = 5.obs;
  RxInt pageFollowingCount = 1.obs;
  RxInt limitFollowingCount = 5.obs;
  RxInt pageSuggestedCount = 3.obs;
  RxInt limitSuggestedCount = 10.obs;

  List<int> pages = <int>[].obs;
  List<int> pages2 = <int>[].obs;

  RxInt tapCount = 0.obs;
  RxInt tapCount2 = 0.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    pageController1.value = PageController(initialPage: currentForYouIndex.value, viewportFraction: 1, keepPage: true);
    suggestedController.value = PageController(viewportFraction: 0.7);
    pageController1.value.addListener(_scrollListener);
    suggestedController.value.addListener(() {
      currentPage.value = suggestedController.value.page!;
    });
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    pageController1.value.removeListener(_scrollListener);
    videoPageController.value.dispose();
    super.onClose();
  }

  void _scrollListener() {
    if (pageController1.value.position.pixels == pageController1.value.position.maxScrollExtent) {
      fetchMoreVideos();
    }
  }

  Future<void> getPostsForYou({required int page, required int limit}) async {
    try {
      var response = await apiImplementation.getPostsForYou(page, limit);

      if (response.c == 200 && response.d != null) {
        postsForYouResponse = response.d!;
        postsForYouData.addAll(postsForYouResponse!.list);
        pages.addAll(List.generate(postsForYouData.length, (index) => index));
        await getPostsFollowing(page: pageFollowingCount.value, limit: limitFollowingCount.value);
      } else if (response.c == 401) {
        ToastHelper.error(response.m);
      } else {
        ToastHelper.error(response.m);
      }
    } catch (ex) {
      log("Something went wrong! for you ${ex.toString()}");
    }
  }

  Future<void> getPostsFollowing({required int page, required int limit}) async {
    try {
      var response = await apiImplementation.getPostsFollowing(page, limit);

      if (response.c == 200 && response.d != null) {
        postsFollowingResponse = response.d!;
        postsFollowingData.addAll(postsFollowingResponse!.list);
        pages2.addAll(List.generate(postsFollowingData.length, (index) => index));
        if (postsFollowingData.isEmpty) {
          await getSuggestToFollow(page: pageSuggestedCount.value, limit: limitSuggestedCount.value);
        }
        update();
      } else if (response.c == 401) {
        ToastHelper.error(response.m);
      } else {
        ToastHelper.error(response.m);
      }
    } catch (ex) {
      log("Something went wrong! following ${ex.toString()}");
    }
  }

  Future<void> getSuggestToFollow({required int page, required int limit}) async {
    try {
      var response = await apiImplementation.getSuggestToFollow(page, limit);

      if (response.c == 200 && response.d != null) {
        suggestToFollowResponse = response.d!;
        suggestToFollowData.addAll(suggestToFollowResponse!.list);
        // pages2.addAll(List.generate(postsFollowingData.length, (index) => index));
      } else if (response.c == 401) {
        ToastHelper.error(response.m);
      } else {
        ToastHelper.error(response.m);
      }
    } catch (ex) {
      log("Something went wrong! suggest ${ex.toString()}");
    }
  }

  Future<void> followUser({required String userId}) async {
    isFollowedClicked(true);
    try {
      var response = await apiImplementation.followUser(userId);

      if (response.c == 200 && response.d != null) {
        await getPostsFollowing(page: pageFollowingCount.value, limit: limitFollowingCount.value);
        followedUserData.add(userId);
        ToastHelper.success(response.m);

        update();
      } else if (response.c == 401) {
        ToastHelper.error(response.m);
      } else {
        ToastHelper.error(response.m);
      }
    } catch (ex) {
      log("Something went wrong! followUser ${ex.toString()}");
    }
    isFollowedClicked(false);
  }

  Future<void> unfollowUser({required String userId}) async {
    isFollowedClicked(true);
    try {
      var response = await apiImplementation.unfollowUser(userId);

      if (response.contains("Successfully unfollowed this user")) {
        await getSuggestToFollow(page: pageSuggestedCount.value, limit: limitSuggestedCount.value);
        followedUserData.remove(userId);
        ToastHelper.success(response);
        update();
      } else {
        ToastHelper.error(response);
      }
    } catch (ex) {
      log("Something went wrong! unfollowUser ${ex.toString()}");
    }
    isFollowedClicked(false);
  }

  // void initializeVideos() {
  //   postModelItems.addAll(initialPostData);
  //   pages.addAll(List.generate(postModelItems.length, (index) => index));
  // }

  void fetchMoreVideos() async {
    // if (isLoading.value) return;
    // isLoading.value = true;
    // await Future.delayed(const Duration(seconds: 1));
    // postModelItems.addAll(getMorePostData);
    // postModelItems.refresh();
    // pages.addAll(List.generate(getMorePostData.length, (index) => pages.length + index));

    // isLoading.value = false;
  }

  Future<void> onRefreshVideo() async {
    // await Future.delayed(const Duration(seconds: 1)).then((value) {});
    // postModelItems.clear();
    // postModelItems.addAll(onRefreshPostData);
    // postModelItems.refresh();
    // pageController2.value
    //     .animateToPage(onRefreshPostData.indexOf(postModelItems.first), duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    // update();
    // isPostDataRefreshed.value = true;
  }

  void handleBottomNavigationTap() {
    tapCount.value++;
    if (tapCount.value == 2 && currentForYouIndex.value != 0) {
      pageController1.value.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    } else if (tapCount.value >= 3) {
      tapCount.value = 0;
      triggerRefreshIndicator();
    }
  }

  void triggerRefreshIndicator() {
    refreshIndicatorKey.currentState?.show(atTop: true);
    if (pageController1.value.hasClients) {
      pageController1.value.animateTo(0.0, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut).then((_) => onRefreshVideo());
    }
  }

  void onTabSelected(int index) {
    selectedTabIndex.value = index;
    videoPageController.value.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    if (selectedTabIndex.value == 1) {
      cachedVideoPlayerPlusController?.play();
    }
  }

  void onPageChanged(int index) {
    selectedTabIndex.value = index;
  }
}

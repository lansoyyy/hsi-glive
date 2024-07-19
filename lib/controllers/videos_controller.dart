import 'dart:developer';
import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VideosController extends GetxController {
  CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
  VoidCallback? videoPlayerListener;
  RxInt videoTapCount = 0.obs;
  RxBool isVideoPlaying = false.obs;
  RxBool isInitialized = false.obs;

  Future<void> startVideoPlayer(XFile? videoFile, XFile? imageFile) async {
    if (videoFile == null) {
      return;
    }

    final CachedVideoPlayerPlusController vController = CachedVideoPlayerPlusController.file(File(videoFile.path));
    videoPlayerListener = () {
      if (cachedVideoPlayerPlusController != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (Get.context!.mounted) {
          update();
        }
        cachedVideoPlayerPlusController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    await vController.initialize();
    isInitialized.value = true;
    await cachedVideoPlayerPlusController?.dispose();
    if (Get.context!.mounted) {
      imageFile = null;
      cachedVideoPlayerPlusController = vController;
      update();
    }
    // await vController.play();
    // if (videoFile != null) {
    //   thumbnailFile.value = await VideoCompress.getFileThumbnail(videoFile!.path, quality: 50, position: -1);
    //   log("NEW FILE ${thumbnailFile.value!.path}");
    // }
  }

  Future<void> reinitiaalizeVideoPlayer(String dataFilePath) async {
    if (dataFilePath.isEmpty) {
      return;
    }

    final CachedVideoPlayerPlusController vController = CachedVideoPlayerPlusController.file(File(dataFilePath));
    videoPlayerListener = () {
      if (cachedVideoPlayerPlusController != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (Get.context!.mounted) {
          update();
        }
        cachedVideoPlayerPlusController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    await vController.initialize();
    isInitialized.value = true;
    await cachedVideoPlayerPlusController?.dispose();
    if (Get.context!.mounted) {
      cachedVideoPlayerPlusController = vController;
      update();
    }
    await vController.play();
  }

  // void resetVideoController() {
  //   videoFile = null;
  //   imageFile = null;
  //   videoTapCount.value = 0;
  //   isVideoPlaying.value = false;
  // }

  @override
  void onInit() {
    // TODO: implement onInit
    log("Init VideoController ");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    log("Close VideoController ");
    super.onClose();
  }
}

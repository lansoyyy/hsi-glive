// ignore_for_file: unused_local_variable, unused_import

import 'dart:developer';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/network/ApiEndpoints.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoPlayerItem extends StatefulWidget {
  final int postIndex;
  final int mediaIndex;

  const VideoPlayerItem({super.key, required this.postIndex, required this.mediaIndex});
  @override
  State<VideoPlayerItem> createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  final VideoController videoController = Get.find();
  late CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    initializeVidePleyer();
  }

  void initializeVidePleyer() {
    var postMediaUrl = videoController.postsForYouData[widget.postIndex].media[widget.mediaIndex].url;
    log("postsForYouResponse URL https://${postMediaUrl.toString()}");
    cachedVideoPlayerPlusController = CachedVideoPlayerPlusController.networkUrl(
      Uri.parse("https://${postMediaUrl.toString()}"),
      videoPlayerOptions: VideoPlayerOptions(mixWithOthers: true),
      invalidateCacheIfOlderThan: const Duration(days: 1),
    )..initialize().then((value) {
        if (widget.postIndex == 0) {
          cachedVideoPlayerPlusController?.play();
          videoController.isVideoPlaying.value = true;
          cachedVideoPlayerPlusController?.setLooping(true);
          cachedVideoPlayerPlusController?.setVolume(1);
        } else {
          videoController.isVideoPlaying.value = false;
          cachedVideoPlayerPlusController?.pause();
        }
        setState(() {});
      });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    cachedVideoPlayerPlusController?.dispose();
    cachedVideoPlayerPlusController = null;
  }

  int tapCount = 0;
  bool playIconVisible = false;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => VisibilityDetector(
        key: ObjectKey(cachedVideoPlayerPlusController!.dataSource),
        onVisibilityChanged: (visibilityInfo) {
          var visiblePercentage = visibilityInfo.visibleFraction * 100;
          //Video is not visible in the screen
          if (visibilityInfo.visibleFraction == 0 && mounted) {
            cachedVideoPlayerPlusController?.pause();
            videoController.isVideoPlaying.value = false;
            videoController.isVideoVisible.value = false;
            setState(() {
              playIconVisible = true;
            });
          } else if (visiblePercentage >= 70) {
            if (widget.postIndex != 0) {
              // initVideoPlayerController();
              videoController.isVideoPlaying.value = true;
              videoController.isVideoVisible.value = true;
              setState(() {
                cachedVideoPlayerPlusController?.play();
                cachedVideoPlayerPlusController?.setLooping(true);
                cachedVideoPlayerPlusController?.setVolume(1);
                playIconVisible = false;
              });
            }
          }
        },
        child: GestureDetector(
            onTap: () {
              setState(() {
                tapCount++;
              });
              if (tapCount % 2 == 0) {
                cachedVideoPlayerPlusController?.pause();
                videoController.isVideoPlaying.value = false;
                setState(() {
                  playIconVisible = true;
                });
              } else {
                cachedVideoPlayerPlusController?.play();
                videoController.isVideoPlaying.value = true;
                setState(() {
                  playIconVisible = false;
                });
              }
            },
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                color: Colors.black,
                image: DecorationImage(
                    image: NetworkImage("https://${videoController.postsForYouData[widget.postIndex].media[widget.mediaIndex].thumbnail.toString()}"),
                    fit: BoxFit.cover),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  CachedVideoPlayerPlus(cachedVideoPlayerPlusController!, key: Key(widget.postIndex.toString())),
                  Container(height: size.height, width: size.width, decoration: BoxDecoration(color: Colors.black.withOpacity(0.2))),
                  Center(
                    child: (playIconVisible)
                        ? Icon(Icons.play_arrow, size: 100.r, color: Colors.white12.withOpacity(0.5))
                        : const Icon(Icons.pause_circle_outline_outlined, color: Colors.transparent),
                  ),
                ],
              ),
            )),
      ),
    );
  }
}

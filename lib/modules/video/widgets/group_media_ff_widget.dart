import 'dart:developer';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:visibility_detector/visibility_detector.dart';

class GroupMediaFFWidget extends StatelessWidget {
  final int postIndex;
  final int mediaIndex;

  const GroupMediaFFWidget({super.key, required this.postIndex, required this.mediaIndex});

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.find();
    return PageView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: videoController.postsFollowingData[postIndex].media.length,
      itemBuilder: (context, index) {
        return MediaWidget(postIndex: postIndex, mediaIndex: mediaIndex, urlIndex: index);
      },
    );
  }
}

class MediaWidget extends StatefulWidget {
  final int postIndex;
  final int mediaIndex;
  final int urlIndex;

  const MediaWidget({
    super.key,
    required this.postIndex,
    required this.mediaIndex,
    required this.urlIndex,
  });

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  final VideoController videoController = Get.find();
  CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
  String postMediaUrl = "";
  String mediaType = "";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    postMediaUrl = videoController.postsFollowingData[widget.postIndex].media[widget.mediaIndex].url.toString();
    mediaType = videoController.postsFollowingData[widget.postIndex].media[widget.mediaIndex].type.toString();
    if (mediaType.contains("video/quicktime")) {
      initializeVidePleyer();
      setState(() {});
    }
  }

  void initializeVidePleyer() {
    log("postsForYouResponse URL https://${postMediaUrl.toString()}");
    if (mediaType.contains("video/quicktime")) {
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
        });
    } else {
      cachedVideoPlayerPlusController!.initialize();
    }

    setState(() {});
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
    var mediaType = videoController.postsFollowingData[widget.postIndex].media[widget.mediaIndex].type;
    if (mediaType!.contains("video/quicktime")) {
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
                      image: NetworkImage(
                          "https://${videoController.postsFollowingData[widget.postIndex].media[widget.mediaIndex].thumbnail.toString()}"),
                      onError: (exception, stackTrace) {},
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
    } else {
      return Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(color: Colors.black),
          child: Image.network("https://${videoController.postsFollowingData[widget.postIndex].media[widget.mediaIndex].url.toString()}",
              errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
            return errorImageContainer();
          }, loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
            if (loadingProgress == null) {
              return child;
            }
            return Center(
              child: CircularProgressIndicator(
                value: loadingProgress.expectedTotalBytes != null
                    ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                    : null,
              ),
            );
          }, fit: BoxFit.cover));
    }
  }
}

Widget errorImageContainer() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Icon(Icons.info_rounded, color: Colors.white, size: 40.r),
      SizedBox(height: 24.sp),
      Text(
        'Failed to load image',
        style: TextStyle(color: Colors.white, fontSize: 14.sp),
      ),
    ],
  );
}

// ignore_for_file: unused_import

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/widgets/main_body_widget.dart';
import 'package:glive/modules/video/widgets/top_bar_widget.dart';
import 'package:glive/modules/video/widgets/video_player_item.dart';
import 'package:glive/modules/video/widgets/video_player_widget.dart';

class VideoPage extends StatefulWidget {
  final String pageName;
  final int index;

  const VideoPage({super.key, required this.pageName, required this.index});

  @override
  State<VideoPage> createState() => _VideoPageState();
}

class _VideoPageState extends State<VideoPage> with AutomaticKeepAliveClientMixin {
  final VideoController videoController = Get.find();
  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      videoController.pageController2.value.jumpToPage(videoController.currentVideoIndex.value);
      videoController.tapCount.value = 0;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      body: RefreshIndicator(
        key: videoController.refreshIndicatorKey,
        onRefresh: () async {
          videoController.isVideoPlaying.value = false;
          await videoController.onRefreshVideo();
        },
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: AppColors.bgGradientColors,
              stops: [0.0891, 0.9926],
              transform: GradientRotation(263.49 * (3.14159 / 180)),
            ),
          ),
          width: double.infinity,
          height: double.infinity,
          child: Obx(() {
            return PageView.builder(
                controller: videoController.pageController2.value,
                // itemCount: videoController.videoUrls.length,
                itemCount: videoController.postModelItems.length,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  videoController.currentVideoIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Obx(() => Column(
                          children: videoController.postModelItems[index].postMedias
                              .asMap()
                              .entries
                              .map((entry) => Expanded(child: VideoPlayerItem(postIndex: index, mediaIndex: entry.key)))
                              .toList())),
                      // VideoPlayerWidget(videoUrl: videoController.videoUrls[index], index: index),
                      TopBarWidget(postModel: videoController.postModelItems[index]),
                      MainBodyWidget(postModel: videoController.postModelItems[index]),
                    ],
                  );
                });
          }),
        ),
      ),
    );
  }
}

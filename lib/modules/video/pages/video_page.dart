// ignore_for_file:

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/widgets/group_media_widget.dart';
import 'package:glive/modules/video/widgets/main_body_widget.dart';
import 'package:glive/modules/video/widgets/top_bar_widget.dart';

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
      videoController.pageController1.value.jumpToPage(videoController.currentForYouIndex.value);
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
                controller: videoController.pageController1.value,
                // itemCount: videoController.videoUrls.length,
                itemCount: videoController.postsForYouData.length,
                scrollDirection: Axis.vertical,
                onPageChanged: (index) {
                  videoController.currentForYouIndex.value = index;
                },
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Obx(() => Column(
                          children: videoController.postsForYouData[index].media
                              .asMap()
                              .entries
                              .map((entry) => Expanded(child: GroupMediaWidget(postIndex: index, mediaIndex: entry.key)))
                              .toList())),
                      // VideoPlayerWidget(videoUrl: videoController.videoUrls[index], index: index),
                      TopBarWidget(postModel: videoController.postsForYouData[index]),
                      MainBodyWidget(postModel: videoController.postsForYouData[index]),
                    ],
                  );
                });
          }),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/pages/following_page.dart';
import 'package:glive/modules/video/pages/for_you_page.dart';
import 'package:glive/modules/video/pages/video_page.dart';

class VideoTabView extends StatefulWidget {
  const VideoTabView({super.key});

  @override
  State<VideoTabView> createState() => _VideoTabViewState();
}

class _VideoTabViewState extends State<VideoTabView> with AutomaticKeepAliveClientMixin {
  final VideoController videoController = Get.find();
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
        body: Container(
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
      child: Obx(
        () {
          return Stack(
            children: [
              PageView(
                controller: videoController.videoPageController.value,
                onPageChanged: videoController.onPageChanged,
                children: const [
                  FollowingPage(pageName: "Following", index: 0),
                  ForYouPage(pageName: "For You'", index: 1),
                  VideoPage(key: Key('video_screen'), pageName: "Video", index: 2),
                ],
              ),
              Positioned(
                top: 105.h,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildTabText('Following', 0).paddingOnly(right: 20.w),
                    _buildTabText('For You', 1).paddingOnly(right: 20.w),
                    _buildTabText('Video', 2),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    ));
  }

  Widget _buildTabText(String text, int index) {
    return GestureDetector(
      onTap: () => videoController.onTabSelected(index),
      child: Obx(
        () => Column(
          children: [
            Text(
              text,
              style: TextStyle(
                color: videoController.selectedTabIndex.value == index ? Colors.white : Colors.white,
                fontSize: 15.sp,
                fontWeight: videoController.selectedTabIndex.value == index ? FontWeight.bold : FontWeight.w700,
                shadows: [
                  Shadow(
                    offset: const Offset(0.1, 0.1),
                    blurRadius: 1.0,
                    color: Colors.black.withOpacity(0.1),
                  ),
                ],
              ),
            ).paddingOnly(bottom: 4.h),
            if (videoController.selectedTabIndex.value == index)
              Container(
                width: 24.w,
                height: 2.h,
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      offset: const Offset(0.1, 0.1),
                      blurRadius: 1.0,
                      color: Colors.black.withOpacity(0.1),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

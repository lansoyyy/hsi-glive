import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/widgets/group_media_ff_widget.dart';
import 'package:glive/modules/video/widgets/main_body_ff_widget.dart';
import 'package:glive/modules/video/widgets/top_bar_ff_widget.dart';

class FollowingPage extends StatelessWidget {
  final String pageName;
  final int index;
  const FollowingPage({super.key, required this.pageName, required this.index});

  @override
  Widget build(BuildContext context) {
    final VideoController videoController = Get.find();
    double max(double a, double b) => a > b ? a : b;
    log("LEN ${videoController.postsFollowingData.length}");
    return Scaffold(
        backgroundColor: Colors.black,
        body: Obx(
          () => videoController.postsFollowingData.isNotEmpty
              ? RefreshIndicator(
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
                          itemCount: videoController.postsForYouData.length,
                          scrollDirection: Axis.vertical,
                          onPageChanged: (index) {
                            videoController.currentFollowingIndex.value = index;
                          },
                          itemBuilder: (context, index) {
                            return Stack(
                              children: [
                                Obx(() => Column(
                                    children: videoController.postsFollowingData[index].media
                                        .asMap()
                                        .entries
                                        .map((entry) => Expanded(child: GroupMediaFFWidget(postIndex: index, mediaIndex: entry.key)))
                                        .toList())),
                                TopBarFFWidget(postModel: videoController.postsFollowingData[index]),
                                MainBodyFFWidget(postModel: videoController.postsFollowingData[index]),
                              ],
                            );
                          });
                    }),
                  ),
                )
              : Stack(
                  children: [
                    Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Center(
                            child: Text("Trending creators",
                                textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500)),
                          ).paddingOnly(bottom: 4.h),
                          Center(
                            child: Text("Follow an account to see their latest \nvideos here.",
                                textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400)),
                          ).paddingOnly(bottom: 24.h),
                          SizedBox(
                              height: 320.sp,
                              width: double.infinity,
                              child: Obx(
                                () => PageView.builder(
                                    scrollDirection: Axis.horizontal,
                                    controller: videoController.suggestedController.value,
                                    itemCount: videoController.suggestToFollowData.length,
                                    physics: const AlwaysScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      double scale = max(0.8, 1 - (index - videoController.currentPage.value).abs() * 0.3);
                                      return Container(
                                        height: Curves.easeOut.transform(scale) * 280.sp,
                                        width: Curves.easeOut.transform(scale) * 150.sp,
                                        margin: EdgeInsets.symmetric(horizontal: 10.sp),
                                        decoration: BoxDecoration(
                                          image: const DecorationImage(
                                              image: NetworkImage(
                                                "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
                                              ),
                                              fit: BoxFit.cover),
                                          borderRadius: BorderRadius.circular(8),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            CircleAvatar(
                                              backgroundImage: const NetworkImage(
                                                  "https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
                                              radius: 38.r,
                                            ).paddingOnly(bottom: 12.h),
                                            Center(
                                              child: Text(
                                                  videoController.suggestToFollowData[index].fullName.isEmpty
                                                      ? "GLive User"
                                                      : videoController.suggestToFollowData[index].fullName,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
                                            ).paddingOnly(bottom: 4.h),
                                            Center(
                                              child: Text(
                                                  videoController.suggestToFollowData[index].firstName.isEmpty
                                                      ? "@GLive User"
                                                      : "@${videoController.suggestToFollowData[index].firstName}",
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w300)),
                                            ).paddingOnly(bottom: 8.h),
                                            Obx(
                                              () => videoController.followedUserData.contains(videoController.suggestToFollowData[index].id)
                                                  ? GestureDetector(
                                                      onTap: () {
                                                        log("UnFollow Tap ${videoController.suggestToFollowData[index].id}");
                                                        videoController.unfollowUser(userId: videoController.suggestToFollowData[index].id);
                                                      },
                                                      child: Container(
                                                        height: 45.sp,
                                                        width: 180.sp,
                                                        decoration:
                                                            BoxDecoration(borderRadius: BorderRadius.circular(8), color: Colors.pink.shade100),
                                                        child: Center(
                                                          child: Obx(
                                                            () => videoController.isFollowedClicked.value
                                                                ? Container(
                                                                    height: 10.sp,
                                                                    width: 8.sp,
                                                                    padding: EdgeInsets.all(8.sp),
                                                                    child: const Center(
                                                                        child: CircularProgressIndicator.adaptive(backgroundColor: Colors.black87)))
                                                                : Center(
                                                                    child: Text(
                                                                      "Following",
                                                                      style: TextStyle(
                                                                          color: Colors.black87, fontSize: 16.sp, fontWeight: FontWeight.w700),
                                                                    ),
                                                                  ),
                                                          ),
                                                        ),
                                                      ).paddingOnly(bottom: 6.h),
                                                    )
                                                  : GestureDetector(
                                                      onTap: () {
                                                        log("Follow Tap ${videoController.suggestToFollowData[index].id}");
                                                        videoController.followUser(userId: videoController.suggestToFollowData[index].id);
                                                      },
                                                      child: Container(
                                                        height: 45.sp,
                                                        width: 180.sp,
                                                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(8.sp), color: Colors.pink),
                                                        child: Obx(
                                                          () => videoController.isFollowedClicked.value
                                                              ? Container(
                                                                  height: 10.sp,
                                                                  width: 8.sp,
                                                                  padding: EdgeInsets.all(8.sp),
                                                                  child: const Center(child: CircularProgressIndicator.adaptive()))
                                                              : Center(
                                                                  child: Text(
                                                                    "Follow",
                                                                    style:
                                                                        TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w400),
                                                                  ),
                                                                ),
                                                        ),
                                                      ).paddingOnly(bottom: 6.h),
                                                    ),
                                            )
                                          ],
                                        ),
                                      ).paddingOnly(bottom: 12.h);
                                    }),
                              ))
                        ],
                      ),
                    ),
                    Positioned(
                      top: 45.h,
                      left: 0,
                      right: 1.w,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(Icons.search, color: Colors.white, size: 30.r).paddingOnly(right: 8.w),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
        ));
  }
}

//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Text("Connect with friends to view their posts",
//                   textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.bold)),
//             ).paddingOnly(bottom: 16.h),
//             Container(
//               height: 50.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.white,
//               ),
//               child: Center(
//                   child: Text(
//                 "Connect with contacts",
//                 style: TextStyle(color: Colors.black, fontSize: 14.sp, fontWeight: FontWeight.w400),
//               )),
//             ).paddingOnly(bottom: 12.h),
//             Container(
//               height: 50.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey.shade700,
//               ),
//               child: Center(
//                   child: Text(
//                 "Connect with Facebook friends",
//                 style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
//               )),
//             ).paddingOnly(bottom: 12.h),
//             Container(
//               height: 50.h,
//               width: double.infinity,
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(8),
//                 color: Colors.grey.shade700,
//               ),
//               child: Center(
//                   child: Text(
//                 "Invite friends",
//                 style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400),
//               )),
//             )
//           ],
//         ).paddingOnly(left: 24.w, right: 24.w, top: 100.h),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:glive/modules/video/widgets/group_media_widget.dart';
import 'package:glive/modules/video/widgets/main_body_widget.dart';
import 'package:glive/modules/video/widgets/top_bar_widget.dart';

class ForYouPage extends StatefulWidget {
  final String pageName;
  final int index;
  const ForYouPage({super.key, required this.pageName, required this.index});

  @override
  State<ForYouPage> createState() => _ForYouPageState();
}

class _ForYouPageState extends State<ForYouPage> with AutomaticKeepAliveClientMixin {
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
                  videoController.isPostsLike.value = videoController.postsForYouData[index].isLike;
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

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Positioned(
//             top: 45.h,
//             left: 0,
//             right: 1.w,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 0.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.end,
//                 children: [
//                   Icon(Icons.search, color: Colors.white, size: 30.r).paddingOnly(right: 8.w),
//                 ],
//               ),
//             ),
//           ),
//           Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Center(
//                   child: Text("Trending creators",
//                       textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 24.sp, fontWeight: FontWeight.w500)),
//                 ).paddingOnly(bottom: 4.h),
//                 Center(
//                   child: Text("Follow an account to see their latest \nvideos here.",
//                       textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w400)),
//                 ).paddingOnly(bottom: 24.h),
//                 Container(
//                   height: 320.h,
//                   width: double.infinity,
//                   decoration: BoxDecoration(
//                     image: const DecorationImage(
//                         image: NetworkImage(
//                           "https://images.unsplash.com/photo-1534528741775-53994a69daeb?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=464&q=80",
//                         ),
//                         fit: BoxFit.cover),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     mainAxisAlignment: MainAxisAlignment.end,
//                     children: [
//                       CircleAvatar(
//                         backgroundImage: const NetworkImage(
//                             "https://images.unsplash.com/photo-1523824921871-d6f1a15151f1?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=687&q=80"),
//                         radius: 38.r,
//                       ).paddingOnly(bottom: 12.h),
//                       Center(
//                         child: Text("Tony Pogi",
//                             textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w500)),
//                       ).paddingOnly(bottom: 4.h),
//                       Center(
//                         child: Text("@tonypogi",
//                             textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.w300)),
//                       ).paddingOnly(bottom: 8.h),
//                       Container(
//                         height: 45.h,
//                         width: 180.w,
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(8),
//                           color: Colors.pink,
//                         ),
//                         child: Center(
//                             child: Text(
//                           "Follow",
//                           style: TextStyle(color: Colors.white, fontSize: 19.sp, fontWeight: FontWeight.w400),
//                         )),
//                       ).paddingOnly(bottom: 16.h),
//                     ],
//                   ),
//                 ).paddingOnly(bottom: 12.h),
//               ],
//             ).paddingOnly(left: 70.w, right: 70.w, top: 50.h),
//           ),
//         ],
//       ),
//     );
//   }
// }

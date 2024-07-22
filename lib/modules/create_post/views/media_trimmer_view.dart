// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/widgets/AppPageBackground.dart';
import 'package:video_trimmer/video_trimmer.dart';

class MediaTrimmerView extends StatelessWidget {
  MediaTrimmerView({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    if (controller.isInitalizedTrimmer.value) {
      controller.loadVideoForTrim();
    } else {
      controller.reinitializeTrimmer();
    }
    return WillPopScope(
      onWillPop: () async {
        if (Navigator.of(context).userGestureInProgress) {
          controller.clearTrimmerVarialbes();
          return false;
        } else {
          controller.clearTrimmerVarialbes();
          return true;
        }
      },
      child: Scaffold(
        body: AppPageBackground(
          child: SafeArea(
            child: Column(
              children: [
                SizedBox(
                  height: 48.sp,
                  width: double.infinity,
                  child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    TextButton(
                        onPressed: () {
                          for (var path in controller.thumbnailListPaths) {
                            controller.deleteCachedFile(path);
                          }
                          controller.clearTrimmerVarialbes();
                          Get.back();
                        },
                        child: Text("Cancel", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w400))),
                    Text(
                      "Create Post",
                      style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
                    ),
                    TextButton(
                        onPressed: controller.progressVisibility.value ? null : () => controller.saveTrimmedVideo(),
                        child: Text("Next", style: TextStyle(color: Colors.blue, fontSize: 15.sp, fontWeight: FontWeight.w400)))
                  ]),
                ).paddingSymmetric(horizontal: 6.sp),
                Obx(() => Visibility(
                      visible: controller.progressVisibility.value,
                      child: const LinearProgressIndicator(backgroundColor: Colors.red),
                    )),
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Obx(() => AspectRatio(aspectRatio: 1, child: VideoViewer(trimmer: controller.videoTrimmer!.value))),
                      TextButton(
                        child: Obx(() => controller.isTrimmerPlaying.value
                            ? Icon(Icons.pause_rounded, size: 80.r, color: Colors.white12.withOpacity(0.5))
                            : Icon(Icons.play_arrow_rounded, size: 80.r, color: Colors.white12.withOpacity(0.5))),
                        onPressed: () async {
                          bool playbackState = await controller.videoTrimmer!.value.videoPlaybackControl(
                            startValue: controller.startTrimmerValue.value,
                            endValue: controller.endTrimmerValue.value,
                          );
                          controller.isTrimmerPlaying.value = playbackState;
                        },
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TrimViewer(
                      trimmer: controller.videoTrimmer!.value,
                      viewerHeight: 65.sp,
                      viewerWidth: MediaQuery.of(context).size.width,
                      durationStyle: DurationStyle.FORMAT_MM_SS,
                      maxVideoLength: const Duration(seconds: 30),
                      editorProperties: TrimEditorProperties(
                        borderPaintColor: Colors.yellow,
                        borderWidth: 4,
                        borderRadius: 5,
                        circlePaintColor: Colors.yellow.shade800,
                      ),
                      areaProperties: TrimAreaProperties.edgeBlur(thumbnailQuality: 10),
                      onChangeStart: (value) => controller.startTrimmerValue.value = value,
                      onChangeEnd: (value) => controller.endTrimmerValue.value = value,
                      onChangePlaybackState: (value) => controller.isTrimmerPlaying.value = value,
                    ),
                  ),
                ).paddingOnly(bottom: 20.sp),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
            // Obx(() => !controller.isThumbnailLoading.value
            //         ? const SizedBox.shrink()
            //         : controller.thumbnailListPaths.isNotEmpty
            //             ? SizedBox(
            //                 height: 80.sp,
            //                 child: ListView.builder(
            //                   scrollDirection: Axis.horizontal,
            //                   itemCount: controller.thumbnailListPaths.length,
            //                   itemBuilder: (context, index) {
            //                     return GestureDetector(
            //                       onTap: () {
            //                         controller.videoTrimmer.value.videoPlayerController!.seekTo(
            //                           Duration(
            //                               milliseconds:
            //                                   index * controller.videoTrimmer.value.videoPlayerController!.value.duration.inMilliseconds ~/ 10),
            //                         );
            //                       },
            //                       child: Padding(
            //                         padding: const EdgeInsets.all(2.0),
            //                         child: Image.file(File(controller.thumbnailListPaths[index])),
            //                       ),
            //                     );
            //                   },
            //                 ),
            //               )
            //             : const SizedBox.shrink()),
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/modals/media_post_bottom_sheet.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class MediaBottomWidget extends StatelessWidget {
  MediaBottomWidget({super.key});
  final CreatePostController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 30.sp,
      right: 0.sp,
      left: 0.sp,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.center,
            child: InkWell(
              onTap: () {
                controller.video.isVideoPlaying.value = false;
                MediaPostBottomSheet.showPrivacySettings(context);
              },
              child: IntrinsicWidth(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                  decoration: BoxDecoration(
                      color: const Color(0xFF000000).withOpacity(0.2),
                      border: Border.all(color: Colors.white70, width: 0.1),
                      borderRadius: BorderRadius.circular(24.sp)),
                  child: Row(
                    children: [
                      Icon(Icons.circle, color: Colors.white, size: 16.r),
                      SizedBox(width: 8.w),
                      Obx(() => Text(
                            'Post * ${controller.privacyDesc.value}',
                            style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600),
                          )),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16.sp),
          Container(
            height: 140.sp,
            width: double.infinity,
            decoration: BoxDecoration(color: const Color(0xFF000000).withOpacity(0.3), borderRadius: BorderRadius.circular(10.sp)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    controller.video.isVideoPlaying.value = false;
                    log("TAPPED ADD TTILE");
                  },
                  child: Obx(() => TextField(
                          controller: controller.titleController.value,
                          cursorColor: Colors.white,
                          decoration: InputDecoration(
                            isDense: true,
                            hintText: 'Add a title to chat',
                            hintStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          scrollPadding: const EdgeInsets.all(10.0),
                          autofocus: false,
                          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)))
                      .paddingSymmetric(horizontal: 5.sp)),
                ),
                GestureDetector(
                  onTap: () {
                    controller.video.isVideoPlaying.value = false;
                    log("TAPPED DESCRIPTION");
                    MediaPostBottomSheet.showAddDescriptionBottomSheet(context);
                  },
                  child: Obx(() => Container(
                      height: 40.sp,
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Text(
                        controller.descController.value.text.isEmpty ? 'Description' : controller.descController.value.text,
                        style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                      )).paddingOnly(left: 20.sp)),
                ),
                Container(
                  height: .1.h,
                  width: double.infinity,
                  color: Colors.white54,
                ),
                SizedBox(height: 8.h),
                GestureDetector(
                  onTap: () {
                    controller.video.isVideoPlaying.value = false;
                    MediaPostBottomSheet.showAddHashtagBottomSheet(context);
                  },
                  child: Obx(
                    () => controller.selectedHashtags.isEmpty
                        ? Container(
                            height: 25.sp,
                            width: double.infinity,
                            decoration: const BoxDecoration(
                              color: Colors.transparent,
                            ),
                            child: Center(
                                child: Text(
                              'Add your favorite hastags here',
                              style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                            )))
                        : SizedBox(
                            height: 25.sp,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: controller.selectedHashtags.length,
                                itemBuilder: (context, index) {
                                  return Container(
                                    height: 25.sp,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        border: Border.all(color: Colors.white, width: 0.2),
                                        borderRadius: BorderRadius.circular(15.sp)),
                                    padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                                    child: Center(
                                      child: Text(
                                        controller.selectedHashtags[index].title,
                                        style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                                      ),
                                    ),
                                  ).paddingOnly(right: 8.sp);
                                }),
                          ),
                    // : Row(
                    //     mainAxisAlignment: MainAxisAlignment.start,
                    //     children: [
                    //       Container(
                    //         height: 25.sp,
                    //         decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             border: Border.all(color: Colors.white, width: 0.2),
                    //             borderRadius: BorderRadius.circular(15.sp)),
                    //         padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                    //         child: Center(
                    //           child: Text(
                    //             '#Sexy Lady',
                    //             style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                    //           ),
                    //         ),
                    //       ).paddingOnly(right: 8.sp),
                    //       Container(
                    //         height: 25.sp,
                    //         decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             border: Border.all(color: Colors.white, width: 0.2),
                    //             borderRadius: BorderRadius.circular(15.sp)),
                    //         padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                    //         child: Center(
                    //           child: Text(
                    //             '#game',
                    //             style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                    //           ),
                    //         ),
                    //       ).paddingOnly(right: 8.sp),
                    //       Container(
                    //         height: 25.sp,
                    //         decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             border: Border.all(color: Colors.white, width: 0.2),
                    //             borderRadius: BorderRadius.circular(15.sp)),
                    //         padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                    //         child: Center(
                    //           child: Text(
                    //             '#Sharinglife',
                    //             style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                    //           ),
                    //         ),
                    //       ).paddingOnly(right: 8.sp),
                    //       Container(
                    //         height: 25.sp,
                    //         decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             border: Border.all(color: Colors.white, width: 0.2),
                    //             borderRadius: BorderRadius.circular(15.sp)),
                    //         padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                    //         child: Center(
                    //           child: Text(
                    //             '#lifestyle',
                    //             style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                    //           ),
                    //         ),
                    //       ).paddingOnly(right: 8.sp),
                    //       Container(
                    //         height: 25.sp,
                    //         width: 25.sp,
                    //         decoration: BoxDecoration(
                    //             color: Colors.transparent,
                    //             border: Border.all(color: Colors.white60, width: 0.1),
                    //             // borderRadius: BorderRadius.circular(15.sp),
                    //             shape: BoxShape.circle),
                    //         padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 0.sp),
                    //         child: Center(
                    //           child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 16.r),
                    //         ),
                    //       ),
                    //     ],
                    //   ).paddingSymmetric(horizontal: 8.sp),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              controller.video.isVideoPlaying.value = false;
              MediaPostBottomSheet.showAddSoundsBottomSheet(context);
            },
            child: IntrinsicWidth(
              child: Container(
                height: 36.sp,
                padding: EdgeInsets.symmetric(horizontal: 17.sp),
                decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.2),
                    border: Border.all(color: Colors.white70, width: 0.1),
                    borderRadius: BorderRadius.circular(24.sp)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Obx(() => controller.selectedSoundDesc.value.isEmpty
                        ? Icon(Icons.circle, color: Colors.white, size: 16.r)
                        : Image.asset(controller.selectedMoodDesc.value, height: 20.sp, width: 20.sp)),
                    SizedBox(width: 8.w),
                    Obx(
                      () => Expanded(
                        child: Text(controller.selectedMoodTitle.value.isEmpty ? 'Add Sound' : controller.selectedSoundTitle.value,
                            overflow: TextOverflow.ellipsis, style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ).paddingOnly(bottom: 6.sp, top: 6.sp),
          ButtonWidget(
            label: 'Post Now',
            radius: 10.sp,
            height: 47.sp,
            width: double.infinity,
            color: const Color(0xFF0A9AAA),
            textColor: const Color(0xFFD3D3D3),
            onPressed: () {
              controller.video.isVideoPlaying.value = false;
              log("VIDEO DATA ${controller.outputDataPath.value}");
              log("Post Now");
            },
          ),
        ],
      ).paddingSymmetric(horizontal: 15.sp),
    );
  }
}

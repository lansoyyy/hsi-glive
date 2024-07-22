// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/tabs/post_image_page.dart';
import 'package:glive/modules/create_post/tabs/post_live_page.dart';
import 'package:glive/modules/create_post/tabs/post_video_page.dart';
import 'package:glive/modules/create_post/widgets/create_post_dialog.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/widgets/AppPageBackground.dart';
import 'package:photo_manager/photo_manager.dart';

class CreatePostView extends StatefulWidget {
  const CreatePostView({super.key});

  @override
  State<CreatePostView> createState() => _CreatePostViewState();
}

class _CreatePostViewState extends State<CreatePostView> {
  //} with WidgetsBindingObserver {
  final CreatePostController controller = Get.put(CreatePostController());

  @override
  void initState() {
    // TODO: implement initState
    // WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    // WidgetsBinding.instance.removeObserver(this);
    // TODO: implement dispose
    Get.delete<CreatePostController>();
    super.dispose();
  }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   final CameraController cameraController = controller.camera.controllers;

  //   // App state changed before we got the chance to initialize.
  //   if (cameraController == null || !cameraController.value.isInitialized) {
  //     return;
  //   }
  //   if (state == AppLifecycleState.inactive) {
  //     controller.camera.disposeCamera();
  //   } else if (state == AppLifecycleState.resumed) {
  //     if (controller.selectedPostPageIndex.value == 0) {
  //       controller.camera.reinitializeCamera();
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //
    var height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
        body: AppPageBackground(
      child: Obx(() => Stack(
            children: [
              PageView(
                physics: const NeverScrollableScrollPhysics(),
                controller: controller.postPageController.value,
                onPageChanged: controller.onPageChanged,
                children: [
                  PostViewPage(),
                  PostImagePage(),
                  PostLivePage(),
                ],
              ),
              Positioned(
                  top: height == 0.0 ? 48.sp : height.sp,
                  left: 0.sp,
                  right: 0.sp,
                  child: SizedBox(
                      width: double.infinity,
                      child: Obx(() => controller.camera.isCameraGranted.value == false && controller.camera.isMicrophoneGranted.value == false
                          ? Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                              IconButton(
                                  icon: Icon(Icons.close, size: 24.r),
                                  color: Colors.white,
                                  onPressed: () {
                                    Get.back();
                                  })
                            ])
                          : Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                              IconButton(
                                  icon: Icon(Icons.arrow_back_ios, size: 24.r),
                                  color: controller.selectedPostPageIndex.value == 1 ? Colors.black : Colors.white,
                                  onPressed: () async {
                                    if (!controller.camera.isRecorded.value &&
                                            !controller.camera.isRecording.value &&
                                            controller.selectedPostPageIndex.value == 0 ||
                                        controller.selectedPostPageIndex.value == 1) {
                                      controller.camera.disposeCamera();
                                      Get.back();
                                    } else {
                                      bool resultValue = await CreatePostDialog.showDiscardPostDialog(context);
                                      if (resultValue == true) {
                                        if (controller.camera.isImageFile.value) {
                                          controller.deleteCachedFile(controller.camera.imageFile!.path);
                                        } else if (controller.camera.isVideoFile.value) {
                                          controller.deleteCachedFile(controller.camera.videoFile!.path);
                                        }
                                        Get.back();
                                      }
                                    }
                                  }),
                              Obx(
                                () => Text(
                                  "Create Post",
                                  style: TextStyle(
                                      color: controller.selectedPostPageIndex.value == 1 ? Colors.black : Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                              Obx(() => controller.selectedPostPageIndex.value == 1
                                  ? TextButton(
                                      onPressed: controller.photos.selectedImageAssets.isNotEmpty
                                          ? () {
                                              PhotoManager.clearFileCache();
                                              controller.camera.disposeCamera();
                                              Get.toNamed(AppRoutes.MEDIAPOST);
                                            }
                                          : null,
                                      child: Obx(() => Text("Next",
                                          style: TextStyle(
                                              color: controller.photos.selectedImageAssets.isNotEmpty ? const Color(0xFF008EFF) : Colors.transparent,
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w400))),
                                    )
                                  : IconButton(
                                      icon: Obx(() => Icon(controller.camera.isFlashOn.value == true ? Icons.flash_on : Icons.flash_off, size: 24.r)),
                                      color: Colors.white,
                                      onPressed: controller.camera.controllers != null
                                          ? () {
                                              controller.onFlashModeTapped();
                                            }
                                          : null,
                                    ))
                            ])))),
              Obx(
                () => Positioned(
                  bottom: controller.photos.isImagesScrolled.value ? 0.sp : 20.sp,
                  left: 16.sp,
                  right: 16.sp,
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    height: controller.photos.isImagesScrolled.value ? 0.sp : 50.sp,
                    child: Container(
                      height: controller.photos.isImagesScrolled.value ? 0.sp : 50.sp,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color(0xFF000000).withOpacity(0.7),
                        borderRadius: BorderRadius.circular(30.sp),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              controller.onTabSelected(0);
                            },
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                                child: Obx(() => Text(
                                      "VIDEO",
                                      style: TextStyle(
                                          color: controller.selectedPostPageIndex.value == 0 ? Colors.white : const Color(0xFFDCDCDC),
                                          fontSize: 14.sp,
                                          fontWeight: controller.selectedPostPageIndex.value == 2 ? FontWeight.w700 : FontWeight.w400),
                                    ))),
                          ),
                          SizedBox(width: 12.sp),
                          InkWell(
                            onTap: !controller.camera.isRecording.value && !controller.camera.isRecorded.value
                                ? () {
                                    controller.onTabSelected(1);
                                  }
                                : null,
                            child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                                child: Obx(
                                  () => Text(
                                    "PHOTO",
                                    style: TextStyle(
                                        color: controller.selectedPostPageIndex.value == 1 ? Colors.white : const Color(0xFFDCDCDC),
                                        fontSize: 14.sp,
                                        fontWeight: controller.selectedPostPageIndex.value == 2 ? FontWeight.w700 : FontWeight.w400),
                                  ),
                                )),
                          ),
                          SizedBox(width: 12.sp),
                          InkWell(
                            onTap: !controller.camera.isRecording.value && !controller.camera.isRecorded.value
                                ? () {
                                    controller.onTabSelected(2);
                                  }
                                : null,
                            child: Container(
                              padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                              child: Obx(
                                () => Text(
                                  "LIVE",
                                  style: TextStyle(
                                      color: controller.selectedPostPageIndex.value == 2 ? Colors.white : const Color(0xFFDCDCDC),
                                      fontSize: 14.sp,
                                      fontWeight: controller.selectedPostPageIndex.value == 2 ? FontWeight.w700 : FontWeight.w400),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )),
    ));
  }
}

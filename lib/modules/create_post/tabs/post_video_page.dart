// ignore_for_file: depend_on_referenced_packages, unused_local_variable, unnecessary_null_comparison, prefer_final_fields

import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/camera_access_widget.dart';
import 'package:glive/modules/create_post/widgets/camera_initial_state.dart';
import 'package:glive/modules/create_post/widgets/camera_recorded_state.dart';
import 'package:glive/modules/create_post/widgets/camera_recording_state.dart';
import 'package:glive/modules/create_post/widgets/create_post_dialog.dart';
import 'package:glive/modules/create_post/widgets/media_size_clipper.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:glive/widgets/AppPageBackground.dart';

class PostViewPage extends StatelessWidget {
  PostViewPage({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: AppPageBackground(
        child: Obx(
          () => controller.camera.isCameraGranted.value == false
              ? CameraAccessWidget()
              : Stack(
                  children: [
                    Obx(() => !controller.camera.isInitializedCamera.value
                        ? Container(
                            width: size.width,
                            height: size.height,
                            decoration: const BoxDecoration(color: Colors.black),
                            child: const Center(child: CircularProgressIndicator.adaptive()),
                          )
                        : Listener(
                            onPointerDown: (_) => controller.camera.pointers.value++,
                            onPointerUp: (_) => controller.camera.pointers.value--,
                            child: ClipRect(
                              clipper: MediaSizeClipper(size),
                              child: Transform.scale(
                                scale: 1 / (controller.camera.controllers.value.aspectRatio * size.aspectRatio),
                                alignment: Alignment.topCenter,
                                child: CameraPreview(
                                  controller.camera.controllers,
                                  child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                                    return GestureDetector(
                                      behavior: HitTestBehavior.opaque,
                                      onScaleStart: controller.camera.handleScaleStart,
                                      onScaleUpdate: controller.camera.handleScaleUpdate,
                                      onTapDown: (TapDownDetails details) => controller.camera.onViewFinderTap(details, constraints),
                                    );
                                  }),
                                ),
                              ),
                            ),
                          )),
                    Obx(() => controller.camera.isRecording.value || controller.camera.isRecorded.value
                        ? const SizedBox.shrink()
                        : Positioned(
                            bottom: 215.sp,
                            right: 0.sp,
                            left: 0.sp,
                            child: SizedBox(
                              height: 30.sp,
                              width: double.infinity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      controller.camera.recordDuration.value = 60;
                                    },
                                    child: Obx(
                                      () => Container(
                                          height: 28.sp,
                                          width: 55.sp,
                                          decoration: BoxDecoration(
                                              color: controller.camera.recordDuration.value == 60 ? Colors.white30 : Colors.black.withOpacity(0.4),
                                              border: Border.all(color: Colors.white, width: 0.2),
                                              borderRadius: BorderRadius.circular(15.sp)),
                                          child: Center(
                                            child: Text("1 min",
                                                style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400)),
                                          )),
                                    ),
                                  ),
                                  SizedBox(width: 8.sp),
                                  InkWell(
                                    onTap: () {
                                      controller.camera.recordDuration.value = 30;
                                    },
                                    child: Obx(() => Container(
                                          height: 28.sp,
                                          width: 55.sp,
                                          decoration: BoxDecoration(
                                              color: controller.camera.recordDuration.value == 30 ? Colors.white30 : Colors.black.withOpacity(0.4),
                                              border: Border.all(color: Colors.white, width: 0.2),
                                              borderRadius: BorderRadius.circular(15.sp)),
                                          child: Center(
                                            child: Text("30 s",
                                                style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400)),
                                          ),
                                        )),
                                  ),
                                  SizedBox(width: 8.sp),
                                  InkWell(
                                      onTap: () {
                                        controller.camera.recordDuration.value = 15;
                                      },
                                      child: Obx(
                                        () => Container(
                                          height: 28.sp,
                                          width: 55.sp,
                                          decoration: BoxDecoration(
                                              color: controller.camera.recordDuration.value == 15 ? Colors.white30 : Colors.black.withOpacity(0.4),
                                              border: Border.all(color: Colors.white, width: 0.2),
                                              borderRadius: BorderRadius.circular(15.sp)),
                                          child: Center(
                                              child: Text("15 s",
                                                  style: TextStyle(color: const Color(0xFFFFFFFF), fontSize: 12.sp, fontWeight: FontWeight.w400))),
                                        ),
                                      )),
                                ],
                              ),
                            ))),
                    Positioned(
                      bottom: 0.sp,
                      left: 0.sp,
                      right: 0.sp,
                      child: Container(
                        height: 200.sp,
                        width: double.infinity,
                        color: const Color(0xFF000000).withOpacity(0.7),
                        child: Obx(() => !controller.camera.isRecording.value && !controller.camera.isRecorded.value
                            ? CameraInitialState(
                                onStartPressed: controller.camera.controllers != null &&
                                        controller.camera.isInitializedCamera.value &&
                                        !controller.camera.controllers.value.isRecordingVideo
                                    ? () {
                                        log("LOG onVideoRecordButtonPressed");
                                        controller.camera.onVideoRecordButtonPressed();
                                      }
                                    : null,
                                onFilePressed: () {},
                                onTooglePressed: controller.camera.cameraIndex != null
                                    ? () {
                                        controller.camera.toggleCameraPosition(controller.camera.controllers.description);
                                        log("LOG");
                                      }
                                    : null,
                              )
                            : controller.camera.isRecording.value
                                ? CameraRecordingState(
                                    onStopPressed: controller.camera.controllers != null &&
                                            controller.camera.controllers.value.isInitialized &&
                                            controller.camera.controllers.value.isRecordingVideo
                                        ? () {
                                            controller.camera.onStopButtonPressed();
                                          }
                                        : null,
                                    onTooglePressed: controller.camera.cameraIndex != null
                                        ? () {
                                            controller.camera.toggleCameraPosition(controller.camera.controllers.description);
                                            log("LOG");
                                          }
                                        : null,
                                  )
                                : !controller.camera.isRecording.value && controller.camera.isRecorded.value
                                    ? CameraRecordedState(
                                        onDonePressed: () {
                                          controller.camera.disposeCamera();
                                          Get.toNamed(AppRoutes.MEDIAPOST);
                                        },
                                        onResumePressed: controller.camera.controllers != null &&
                                                controller.camera.controllers.value.isInitialized &&
                                                controller.camera.controllers.value.isRecordingVideo
                                            ? () {}
                                            : null,
                                        onExitPressed: () async {
                                          bool resultValue = await CreatePostDialog.showDiscardPostDialog(context);
                                          if (resultValue == true) {
                                            if (controller.camera.videoFile! != null) {
                                              controller.deleteCachedFile(controller.camera.videoFile!.path);
                                            }
                                            await controller.camera.resetCamera();
                                          }
                                        },
                                        onFilePressed: () {},
                                      )
                                    : Container()),
                        // child: const CameraRecordedState(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

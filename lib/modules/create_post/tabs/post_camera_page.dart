// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';

import 'package:camera/camera.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/camera_initial_state.dart';
import 'package:glive/modules/create_post/widgets/media_size_clipper.dart';
import 'package:glive/widgets/AppPageBackground.dart';

class PostCameraPage extends StatelessWidget {
  PostCameraPage({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    var height = MediaQuery.of(context).viewPadding.top;

    return Scaffold(
      body: AppPageBackground(
        child: Stack(
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
                            child: CameraPreview(controller.camera.controllers,
                                child: LayoutBuilder(builder: (BuildContext context, BoxConstraints constraints) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onScaleStart: controller.camera.handleScaleStart,
                                onScaleUpdate: controller.camera.handleScaleUpdate,
                                onTapDown: (TapDownDetails details) => controller.camera.onViewFinderTap(details, constraints),
                              );
                            })))),
                  )).paddingOnly(bottom: 16.sp),
            Positioned(
                top: height == 0.0 ? 48.sp : height.sp,
                left: 0.sp,
                right: 0.sp,
                child: SizedBox(
                    width: double.infinity,
                    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                      IconButton(
                          icon: Icon(Icons.arrow_back_ios, size: 24.r),
                          color: Colors.white,
                          onPressed: () {
                            controller.isCameraSelected.value = false;
                            controller.camera.disposeCamera();
                            Get.back();
                          }),
                      IconButton(
                        icon: Obx(
                          () => Icon(
                            controller.camera.isFlashOn.value == true ? Icons.flash_on : Icons.flash_off,
                            size: 24.r,
                          ),
                        ),
                        color: Colors.white,
                        onPressed: controller.camera.controllers != null
                            ? () {
                                controller.onFlashModeTapped();
                              }
                            : null,
                      )
                    ]))),
            Positioned(
                bottom: 0.sp,
                left: 0.sp,
                right: 0.sp,
                child: Container(
                  height: 150.sp,
                  width: double.infinity,
                  color: const Color(0xFF000000).withOpacity(0.7),
                  child: Obx(() => CameraInitialState(
                        onStartPressed: controller.camera.isInitializedCamera.value
                            ? () async {
                                log("LOG onVideoRecordButtonPressed");
                                controller.camera.onTakePictureButtonPressed();
                              }
                            : null,
                        onFilePressed: () {},
                        onTooglePressed: controller.camera.cameraIndex != null
                            ? () {
                                controller.camera.toggleCameraPosition(controller.camera.controllers.description);
                                log("LOG");
                              }
                            : null,
                      )),
                ))
          ],
        ),
      ),
    );
  }
}

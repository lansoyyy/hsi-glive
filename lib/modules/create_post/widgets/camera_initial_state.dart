import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/camera_thumbnail_widget.dart';

class CameraInitialState extends StatefulWidget {
  final VoidCallback? onStartPressed;
  final VoidCallback? onFilePressed;
  final VoidCallback? onTooglePressed;

  const CameraInitialState({super.key, required this.onStartPressed, required this.onFilePressed, required this.onTooglePressed});

  @override
  State<CameraInitialState> createState() => _CameraInitialStateState();
}

class _CameraInitialStateState extends State<CameraInitialState> {
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onFilePressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75.sp,
                width: 75.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              ),
              // Obx(() => controller.isStorageGranted.value == true
              //     ? Container(
              //         height: 62.sp,
              //         width: 62.sp,
              //         decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.black),
              //       )
              //     : Container(
              //         height: 62.sp,
              //         width: 62.sp,
              //         decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              //       )),
              CameraThumbnailWidget(),
              // const CircleAvatar(
              //   radius: 25,
              //   backgroundImage: AssetImage(
              //     'assets/images/ivanasexy.png',
              //   ),
              // ),
            ],
          ).paddingOnly(left: 30.sp),
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            GestureDetector(
              onTap: widget.onStartPressed,
              child: Container(
                height: 75.sp,
                width: 75.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
            ),
            GestureDetector(
              onTap: widget.onStartPressed,
              child: Container(
                height: 62.sp,
                width: 62.sp,
                decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.red, border: Border.all(color: Colors.white, width: 1)),
              ),
            ),
          ],
        ),
        GestureDetector(
          onTap: widget.onTooglePressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75.sp,
                width: 75.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
              ),
              Container(
                height: 55.sp,
                width: 55.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white30,
                ),
                child: Icon(
                  Icons.refresh,
                  color: Colors.white,
                  size: 24.r,
                ),
              ),
            ],
          ).paddingOnly(right: 30.sp),
        ),
      ],
    ).paddingOnly(top: 24.sp);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';

class CameraRecordingState extends StatefulWidget {
  final VoidCallback? onStopPressed;
  final VoidCallback? onTooglePressed;
  const CameraRecordingState({super.key, required this.onStopPressed, required this.onTooglePressed});

  @override
  State<CameraRecordingState> createState() => _CameraRecordingStateState();
}

class _CameraRecordingStateState extends State<CameraRecordingState> {
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 75.sp,
              width: 75.sp,
              decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
            ),
          ],
        ).paddingOnly(left: 30.sp),
        GestureDetector(
          onTap: widget.onStopPressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75.sp,
                width: 75.sp,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFFFFFF).withOpacity(0.3)),
                child: Obx(() => CircularProgressIndicator(
                      value: controller.camera.progressDuration.value,
                      valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                    )),
              ),
              Container(
                height: 40.sp,
                width: 40.sp,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.red,
                ),
                child: const Center(
                  child: Icon(
                    Icons.square_rounded,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
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

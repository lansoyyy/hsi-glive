import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/camera_thumbnail_widget.dart';

class CameraRecordedState extends StatefulWidget {
  final VoidCallback? onResumePressed;
  final VoidCallback? onFilePressed;
  final VoidCallback? onExitPressed;
  final VoidCallback? onDonePressed;

  const CameraRecordedState(
      {super.key, required this.onResumePressed, required this.onFilePressed, required this.onExitPressed, required this.onDonePressed});

  @override
  State<CameraRecordedState> createState() => _CameraRecordedStateState();
}

class _CameraRecordedStateState extends State<CameraRecordedState> {
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
              CameraThumbnailWidget(),
            ],
          ).paddingOnly(left: 50.sp),
        ),
        GestureDetector(
          onTap: widget.onResumePressed,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 75.sp,
                width: 75.sp,
                decoration: BoxDecoration(shape: BoxShape.circle, color: const Color(0xFFFFFFFF).withOpacity(0.3)),
                child: CircularProgressIndicator(
                  value: controller.camera.progressDuration.value,
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.red),
                ),
              ),
              Container(
                height: 40.sp,
                width: 40.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.red),
              ),
            ],
          ).paddingOnly(left: 20.sp, right: 12),
        ),
        Row(
          children: [
            GestureDetector(
              onTap: widget.onExitPressed,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 75.sp,
                    width: 60.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                  ),
                  Container(
                    height: 44.sp,
                    width: 44.sp,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 18.r,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.sp),
            GestureDetector(
              onTap: widget.onDonePressed,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 75.sp,
                    width: 60.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                  ),
                  Container(
                    height: 44.sp,
                    width: 44.sp,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFFF3D3D),
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 18.r,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    ).paddingOnly(top: 24.sp);
  }
}

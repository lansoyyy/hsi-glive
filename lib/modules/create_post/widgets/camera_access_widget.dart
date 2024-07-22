import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class CameraAccessWidget extends StatelessWidget {
  CameraAccessWidget({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
                  child: Text('Create a Reels',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: const Color(0xFFFFFFFF))))
              .paddingOnly(bottom: 30.sp),
          Center(
                  child: Text('Allow access to your camera and microphone',
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: const Color(0xFFFFFFFF))))
              .paddingOnly(bottom: 50.sp),
          ButtonWidget(
            label: 'Allow access',
            radius: 10.sp,
            height: 50.sp,
            width: 155.sp,
            fontSize: 16.sp,
            color: const Color(0xFFFFFFFF),
            textColor: const Color(0xFF000000),
            onPressed: () async {
              await controller.onCameraAudioPermissionRequest();
            },
          ).paddingOnly(bottom: 10.h),
        ],
      ),
    );
  }
}

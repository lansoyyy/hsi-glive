// ignore_for_file: unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/create_post_dialog.dart';

class MediaTopWidget extends StatelessWidget {
  MediaTopWidget({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).viewPadding.top;

    return Positioned(
      top: height == 0.0 ? 48.sp : height.sp,
      left: 0.sp,
      right: 0.sp,
      child: SizedBox(
        width: double.infinity,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              size: 24.r,
            ),
            color: Colors.transparent,
            onPressed: () {},
          ),
          Text(
            "Create Post",
            style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700),
          ),
          IconButton(
            icon: Icon(
              Icons.close,
              size: 30.r,
            ),
            color: Colors.white,
            onPressed: () async {
              bool resultValue = await CreatePostDialog.showDiscardPostDialog(context);
              if (resultValue == true) {
                if (controller.camera.isImageFile.value) {
                  controller.deleteCachedFile(controller.camera.imageFile!.path);
                } else if (controller.camera.isVideoFile.value) {
                  controller.deleteCachedFile(controller.camera.videoFile!.path);
                }
                Get.back();
                Get.back();
              }
            },
          )
        ]),
      ),
    );
  }
}

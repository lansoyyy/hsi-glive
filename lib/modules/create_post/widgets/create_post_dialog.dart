// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class CreatePostDialog {
  static Future<bool> showDiscardPostDialog(BuildContext context) async {
    final CreatePostController controller = Get.find();

    return await Get.dialog(
        barrierDismissible: false,
        Dialog(
          backgroundColor: Colors.transparent,
          child: WillPopScope(
            onWillPop: () async => false,
            child: Container(
              height: controller.camera.isRecording.value && controller.selectedPostPageIndex.value == 0 ? 205.sp : 185.sp,
              width: 320.sp,
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  controller.camera.isRecording.value && controller.selectedPostPageIndex.value == 0
                      ? Padding(
                          padding: EdgeInsets.symmetric(vertical: 40.sp),
                          child: Center(
                              child: Text('Recording inprogress. Discard and exit?',
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF262626)))),
                        )
                      : controller.photos.selectedImageAssets.isNotEmpty && controller.selectedPostPageIndex.value == 1
                          ? Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.sp),
                              child: Center(
                                  child: Text('Discard this post?',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF262626)))),
                            )
                          : Padding(
                              padding: EdgeInsets.symmetric(vertical: 40.sp),
                              child: Center(
                                  child: Text('Discard the last clip?',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: const Color(0xFF262626)))),
                            ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ButtonWidget(
                        label: 'Yes',
                        radius: 8.sp,
                        height: 43.sp,
                        width: 135.sp,
                        fontSize: 16.sp,
                        color: const Color(0xFF0A9AAA),
                        textColor: const Color(0xFFD3D3D3),
                        onPressed: () {
                          return Get.back(result: true);
                        },
                      ),
                      SizedBox(width: 12.sp),
                      ButtonWidget(
                        label: 'No',
                        radius: 8.sp,
                        height: 43.sp,
                        width: 135.sp,
                        fontSize: 16.sp,
                        color: Colors.white,
                        textColor: const Color(0xFF0A9AAA),
                        onPressed: () {
                          return Get.back(result: false);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}

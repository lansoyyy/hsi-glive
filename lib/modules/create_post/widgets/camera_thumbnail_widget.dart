import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';

class CameraThumbnailWidget extends StatelessWidget {
  CameraThumbnailWidget({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        //----------IMAGE THUMBNAIL-----------
        Obx(() => controller.photos.firstMedia.value == null && !controller.camera.isVideoFile.value && !controller.camera.isImageFile.value
            ? Container(
                height: 75.sp,
                width: 75.sp,
                decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                padding: EdgeInsets.all(8.sp))
            : controller.photos.firstMedia.value != null && !controller.camera.isVideoFile.value && !controller.camera.isImageFile.value
                ? Container(
                    height: 75.sp,
                    width: 75.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                    padding: EdgeInsets.all(8.sp),
                    child: FutureBuilder<Uint8List?>(
                        future: controller.photos.firstMedia.value!.originBytes,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return snapshot.hasData
                                ? GestureDetector(
                                    onTap: () {
                                      log("Selecting Photo here ");
                                    },
                                    child: CircleAvatar(radius: 25.r, backgroundImage: MemoryImage(snapshot.data!)))
                                : const Center(child: Text('Error loading image'));
                          } else {
                            return const Center(child: CircularProgressIndicator.adaptive());
                          }
                        }))
                : Container(
                    height: 75.sp,
                    width: 75.sp,
                    decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.transparent),
                    padding: EdgeInsets.all(8.sp),
                    child: Obx(() => controller.camera.thumbnailDataPath.value.isNotEmpty
                        ? GestureDetector(
                            onTap: () {
                              log("1Record Video here ${controller.camera.thumbnailDataPath.value}");
                            },
                            child: CircleAvatar(radius: 25.r, backgroundImage: FileImage(File(controller.camera.thumbnailDataPath.value))))
                        : GestureDetector(
                            onTap: () {
                              log("1Capture Photo here ${controller.camera.imageFile!.path} ");
                            },
                            child: CircleAvatar(radius: 25.r, backgroundImage: FileImage(File(controller.camera.imageFile!.path))))))),
      ],
    );
  }
}
//data/user/0/com.example.glive/app_flutter/glive_thumbnail1.jpg => thumbnailDataPath
//data/user/0/com.example.glive/cache/CAP9192905191280039426.jpg => imagefile path
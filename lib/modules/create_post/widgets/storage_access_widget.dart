import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class StorageAccessWidget extends StatelessWidget {
  StorageAccessWidget({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return SizedBox(
      height: size.height,
      width: size.width,
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
                    child: Text('Upload Media',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600, color: const Color(0xFF000000))))
                .paddingOnly(bottom: 30.sp),
            Center(
                    child: Text('Allow access to your media to get started',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.w400, color: const Color(0xFF000000))))
                .paddingOnly(bottom: 50.sp),
            ButtonWidget(
              label: 'Allow access',
              radius: 10.sp,
              height: 50.sp,
              width: 155.sp,
              fontSize: 16.sp,
              color: const Color(0xFF0A9AAA),
              textColor: const Color(0xFFFFFFFF),
              onPressed: () async {
                await controller.photos.checkPhotoManagerPermission();
              },
            ).paddingOnly(bottom: 10.h),
          ],
        ),
      ),
    );
  }
}

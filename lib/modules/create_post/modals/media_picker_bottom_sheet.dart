import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/album_tile_widget.dart';
import 'package:glive/modules/create_post/widgets/bottom_sheet_divider.dart';

class MediaPickerBottomSheet {
  static final CreatePostController controller = Get.find();

  static void showMediaPickerBottomSheet(BuildContext context) {
    Get.bottomSheet(
      Stack(
        children: [
          Container(
            height: Get.height,
            padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
            decoration: const BoxDecoration(
                gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: AppColors.bgGradientColors),
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  bottomSheetDivider().paddingOnly(bottom: 16.sp),
                  SizedBox(
                    height: 40.sp,
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: Text("Cancel", style: TextStyle(color: const Color(0xFFDCDCDC), fontSize: 15.sp, fontWeight: FontWeight.w400))),
                        Text("Select Album", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                        TextButton(
                            onPressed: () {},
                            child: Text("Cancel", style: TextStyle(color: Colors.transparent, fontSize: 12.sp, fontWeight: FontWeight.w400)))
                      ],
                    ),
                  ).paddingOnly(bottom: 16.sp),
                  Obx(
                    () => controller.photos.photoAlbums.isEmpty
                        ? const Center(child: CircularProgressIndicator.adaptive())
                        : GridView.builder(
                            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 4.0,
                              mainAxisSpacing: 4.0,
                            ),
                            shrinkWrap: true,
                            itemCount: controller.photos.photoAlbums.length,
                            itemBuilder: (context, index) {
                              return AlbumTile(controller.photos.photoAlbums[index], controller);
                            },
                          ),
                  ),
                ],
              ),
            ),
          ).paddingOnly(top: kToolbarHeight),
        ],
      ),
      isScrollControlled: true,
    );
  }
}

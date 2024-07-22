import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/album_tile_widget.dart';
import 'package:glive/modules/create_post/widgets/bottom_sheet_divider.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:photo_manager/photo_manager.dart';

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

  static void showVideoPickerBottomSheet(BuildContext context) {
    controller.selectedVideoFiles.clear();
    Get.bottomSheet(
      Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 8.sp),
        decoration: const BoxDecoration(
            gradient: LinearGradient(begin: Alignment.centerLeft, end: Alignment.centerRight, colors: AppColors.bgGradientColors),
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
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
                        Future.delayed(const Duration(milliseconds: 1000), () {
                          controller.photos.selectedVideoAssets.clear();
                          controller.selectedVideoFiles.clear();
                          controller.camera.reinitializeCamera();
                          controller.update();
                        });
                      },
                      child: Text("Cancel", style: TextStyle(color: const Color(0xFFDCDCDC), fontSize: 15.sp, fontWeight: FontWeight.w400))),
                  Text("Select Video", style: TextStyle(color: Colors.white, fontSize: 15.sp, fontWeight: FontWeight.w700)),
                  Obx(() => controller.photos.selectedVideoAssets.isEmpty
                      ? TextButton(
                          onPressed: () {},
                          child: Text("Cancel", style: TextStyle(color: Colors.transparent, fontSize: 15.sp, fontWeight: FontWeight.w400)))
                      : TextButton(
                          onPressed: () {
                            Get.back();
                            Get.toNamed(AppRoutes.MEDIATRIMMER);
                          },
                          child: Text("Done", style: TextStyle(color: Colors.blue, fontSize: 15.sp, fontWeight: FontWeight.w400))))
                ],
              ),
            ).paddingOnly(bottom: 16.sp),
            Obx(
              () => controller.photos.storageVideoList.isEmpty
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4, crossAxisSpacing: 2.0, mainAxisSpacing: 2.0),
                        scrollDirection: Axis.vertical,
                        itemCount: controller.photos.storageVideoList.length,
                        itemBuilder: (context, index) {
                          AssetEntity assets = controller.photos.storageVideoList[index];
                          return FutureBuilder<Uint8List?>(
                              future: assets.thumbnailData,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                  return snapshot.hasData
                                      ? GestureDetector(
                                          onTap: () async {
                                            controller.onVideoSelected(assets);
                                            log("Selecting VIDEO here ${controller.photos.storageVideoList.length}");
                                          },
                                          child: Stack(
                                            children: [
                                              Image.memory(snapshot.data!, fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                                              Obx(() => controller.photos.selectedVideoAssets.contains(assets)
                                                  ? Container(
                                                          decoration: BoxDecoration(
                                                              shape: BoxShape.circle,
                                                              border: Border.all(color: Colors.white, width: 0.1),
                                                              color: Colors.blue),
                                                          padding: EdgeInsets.all(5.sp),
                                                          child: Icon(Icons.check, size: 12.r))
                                                      .paddingAll(6.sp)
                                                  : const SizedBox.shrink()),
                                            ],
                                          ))
                                      : const Center(child: Text('Error loading image'));
                                } else {
                                  return const Center(child: CircularProgressIndicator.adaptive());
                                }
                              });
                        },
                      ),
                    ),
            ),
          ],
        ),
      ).paddingOnly(top: MediaQuery.of(context).padding.top),
      isScrollControlled: true,
    ).whenComplete(() => controller.camera.reinitializeCamera());
  }
}

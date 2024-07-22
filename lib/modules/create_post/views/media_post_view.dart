// ignore_for_file: unrelated_type_equality_checks

import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/media_bottom_widget.dart';
import 'package:glive/modules/create_post/widgets/media_content_widget.dart';
import 'package:glive/modules/create_post/widgets/media_top_widget.dart';
import 'package:glive/widgets/AppPageBackground.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:wechat_assets_picker/wechat_assets_picker.dart';

class MediaPostView extends StatelessWidget {
  MediaPostView({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // log("IMAGE PATH ${controller.camera.imageFile!.path}");
    return Scaffold(
      body: AppPageBackground(
        child: Obx(() => controller.selectedPostPageIndex.value == 0 || controller.selectedVideoFiles.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  controller.onVideoTapped();
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    if (controller.video.cachedVideoPlayerPlusController == null)
                      Container()
                    else
                      Expanded(
                        child: AspectRatio(
                            aspectRatio: controller.video.cachedVideoPlayerPlusController!.value.aspectRatio,
                            child: CachedVideoPlayerPlus(controller.video.cachedVideoPlayerPlusController!)),
                      ),
                    Obx(() => controller.video.isVideoPlaying.value
                        ? Icon(Icons.play_arrow_rounded, color: Colors.transparent, size: 55.r)
                        : Center(
                            child: Container(
                                height: 80.sp,
                                width: 80.sp,
                                decoration:
                                    BoxDecoration(shape: BoxShape.circle, color: Colors.white38, border: Border.all(color: Colors.white, width: 0.4)),
                                child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 55.r)))),
                    MediaTopWidget(),
                    MediaContentWidget(),
                    MediaBottomWidget(),
                  ],
                ),
              )
            : controller.isCameraSelected.value && controller.photos.selectedImageAssets.isEmpty
                ? Stack(
                    children: [
                      Container(
                        height: size.height,
                        width: size.width,
                        decoration: const BoxDecoration(color: Colors.black87),
                        child: Image.file(File(controller.camera.imageFile!.path)),
                      ),
                      MediaTopWidget(),
                      MediaContentWidget(),
                      MediaBottomWidget(),
                    ],
                  )
                : Stack(
                    children: [
                      Obx(() {
                        return PhotoViewGallery.builder(
                          scrollPhysics: const AlwaysScrollableScrollPhysics(),
                          builder: (BuildContext context, int index) {
                            return PhotoViewGalleryPageOptions(
                              imageProvider: AssetEntityImageProvider(controller.photos.selectedImageAssets[index]),
                              initialScale: PhotoViewComputedScale.contained * 1,
                              minScale: PhotoViewComputedScale.contained * 1,
                              maxScale: PhotoViewComputedScale.covered * 2,
                            );
                          },
                          itemCount: controller.photos.selectedImageAssets.length,
                          pageController: PageController(initialPage: 0),
                          onPageChanged: (index) {
                            controller.photos.imagePagesIndex.value = index;
                          },
                        );
                      }),
                      Positioned(
                        bottom: 320.sp,
                        left: 10.sp,
                        right: 10.sp,
                        child: SizedBox(
                          height: 50.sp,
                          width: size.width,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                height: 27.sp,
                                width: 85.sp,
                                decoration: BoxDecoration(
                                    color: const Color(0xFF222222).withOpacity(0.7),
                                    borderRadius: BorderRadius.circular(7.sp),
                                    border: Border.all(color: Colors.white70, width: 0.1)),
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, size: 15.r),
                                    SizedBox(width: 4.sp),
                                    Text(
                                      '${controller.photos.selectedImageAssets.length} image',
                                      style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: List.generate(
                                  controller.photos.selectedImageAssets.length,
                                  (index) => Obx(
                                    () => Container(
                                      width: controller.photos.imagePagesIndex.value == index ? 25.sp : 8.sp,
                                      height: 8.sp,
                                      margin: EdgeInsets.symmetric(horizontal: 4.sp),
                                      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16)),
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 27.sp,
                                width: 85.sp,
                                color: Colors.transparent,
                                padding: const EdgeInsets.all(4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.image, size: 15.r, color: Colors.transparent),
                                    SizedBox(width: 4.sp),
                                    Text(
                                      '${controller.photos.selectedImageAssets.length} image',
                                      style: TextStyle(color: Colors.transparent, fontSize: 12.sp, fontWeight: FontWeight.w400),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      MediaTopWidget(),
                      MediaContentWidget(),
                      MediaBottomWidget(),
                    ],
                  )),
      ),
    );
  }
}

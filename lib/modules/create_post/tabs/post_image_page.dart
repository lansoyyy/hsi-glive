import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/modals/media_picker_bottom_sheet.dart';
import 'package:glive/modules/create_post/widgets/storage_access_widget.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:photo_manager/photo_manager.dart';

class PostImagePage extends StatelessWidget {
  PostImagePage({super.key});
  final CreatePostController controller = Get.find();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    log("PHOTOS ${controller.photos.isPhotoseGranted.value}");
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        color: Colors.white,
        child: SafeArea(
          child: Stack(
            children: [
              Obx(() => !controller.photos.isPhotoseGranted.value
                  ? StorageAccessWidget()
                  : Stack(children: [
                      Container(
                        height: 440.sp,
                        width: double.infinity,
                        decoration: BoxDecoration(color: const Color(0xFF000000).withOpacity(0.9), borderRadius: BorderRadius.circular(20.sp)),
                        child: Obx(() {
                          if (controller.photos.selectedImageAssets.isEmpty && controller.photos.firstMedia.value != null) {
                            return FutureBuilder<Uint8List?>(
                              future: controller.photos.firstMedia.value!.originBytes,
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.done) {
                                  return snapshot.hasData
                                      ? Obx(() => Image.memory(snapshot.data!,
                                          height: double.infinity,
                                          width: double.infinity,
                                          filterQuality: FilterQuality.high,
                                          fit: controller.photos.isImageEnlarge.value ? BoxFit.cover : BoxFit.contain))
                                      : const Center(child: Text('Error loading image'));
                                } else {
                                  return const Center(child: CircularProgressIndicator.adaptive());
                                }
                              },
                            );
                          }
                          return PageView.builder(
                            itemCount: controller.photos.selectedImageAssets.length,
                            clipBehavior: Clip.antiAlias,
                            itemBuilder: (context, index) {
                              return FutureBuilder<Uint8List?>(
                                future: controller.photos.selectedImageAssets[index].originBytes,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.done) {
                                    return snapshot.hasData
                                        ? Obx(() => ClipRRect(
                                              borderRadius: BorderRadius.circular(20.sp),
                                              child: Image.memory(snapshot.data!,
                                                  height: double.infinity,
                                                  width: double.infinity,
                                                  filterQuality: FilterQuality.high,
                                                  fit: controller.photos.isImageEnlarge.value ? BoxFit.cover : BoxFit.contain),
                                            ))
                                        : const Center(child: Text('Error loading image'));
                                  } else {
                                    return const Center(child: CircularProgressIndicator.adaptive());
                                  }
                                },
                              );
                            },
                          );
                        }),
                      ).paddingOnly(left: 10.sp, right: 10.sp, top: 50.sp, bottom: 10.sp),
                      Positioned(
                          top: 60.sp,
                          right: 22.sp,
                          child: GestureDetector(
                            onTap: () {
                              controller.photos.selectedImageAssets.clear();
                            },
                            child: Container(
                                height: 28.sp,
                                width: 28.sp,
                                decoration: BoxDecoration(color: const Color(0xFF262626).withOpacity(0.6), borderRadius: BorderRadius.circular(7.sp)),
                                child: Icon(Icons.close, color: Colors.white, size: 22.r)),
                          )),
                      Positioned(
                          bottom: 20.sp,
                          left: 22.sp,
                          child: GestureDetector(
                            onTap: () {
                              controller.photos.isImageEnlarge.value = !controller.photos.isImageEnlarge.value;
                            },
                            child: Container(
                                height: 30.sp,
                                width: 30.sp,
                                decoration: BoxDecoration(color: const Color(0xFF262626).withOpacity(0.6), borderRadius: BorderRadius.circular(7.sp)),
                                child: Icon(Icons.crop_free, color: Colors.white, size: 24.r)),
                          ))
                    ])),
              Obx(
                () => DraggableScrollableSheet(
                  initialChildSize: 0.47.sp,
                  minChildSize: 0.47.sp,
                  maxChildSize: 1.0.sp - 0.014.sp, // 0.985.sp,
                  controller: controller.draggableScrollableController.value,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return NotificationListener<ScrollNotification>(
                      onNotification: (scrollNotification) {
                        if (scrollNotification is ScrollUpdateNotification) {
                          controller.gridViewScrollListenter();
                        } else if (scrollNotification is UserScrollNotification) {
                          final ScrollDirection direction = scrollNotification.direction;
                          controller.onScrolledImages(direction, scrollNotification);
                        }
                        return false;
                      },
                      child: Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            SingleChildScrollView(
                              controller: scrollController,
                              child: SizedBox(
                                height: controller.photos.isDragging.value == false ? 42.sp : 42.sp,
                                width: double.infinity,
                                child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                                  GestureDetector(
                                    onTap: () {
                                      MediaPickerBottomSheet.showMediaPickerBottomSheet(context);
                                    },
                                    child: SizedBox(
                                      height: 40.sp,
                                      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                        Obx(() => Text(controller.photos.selectedAlbumName.value,
                                            style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400))),
                                        SizedBox(width: 4.w),
                                        Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 24.r)
                                      ]),
                                    ),
                                  ),
                                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                    Obx(() => IconButton(
                                        icon: Icon(Icons.copy_outlined, size: controller.photos.isMultipleSelected.value ? 20.r : 24.r),
                                        color: controller.photos.isMultipleSelected.value ? Colors.white : Colors.black,
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(
                                                controller.photos.isMultipleSelected.value ? const Color(0xFF008EFF) : Colors.transparent)),
                                        onPressed: () {
                                          // controller.photos.addedImageCount.value = 0;
                                          controller.photos.isMultipleSelected.value = !controller.photos.isMultipleSelected.value;
                                        })),
                                    IconButton(
                                        icon: Icon(Icons.camera_alt_outlined, size: 28.r),
                                        color: Colors.black,
                                        splashColor: controller.photos.isMultipleSelected.value ? Colors.transparent : Colors.transparent,
                                        highlightColor: controller.photos.isMultipleSelected.value ? Colors.transparent : Colors.transparent,
                                        focusColor: controller.photos.isMultipleSelected.value ? Colors.transparent : Colors.transparent,
                                        style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(
                                                controller.photos.isMultipleSelected.value ? Colors.transparent : Colors.transparent)),
                                        onPressed: () {
                                          if (!controller.photos.isMultipleSelected.value) {
                                            controller.isCameraSelected.value = true;
                                            controller.camera.reinitializeCamera();
                                            Get.toNamed(AppRoutes.POSTCAMERA);
                                          }
                                        })
                                  ])
                                ]),
                              ).paddingSymmetric(horizontal: 10.sp),
                            ),
                            Expanded(
                              child: Obx(
                                () => controller.photos.storageImagesList.isEmpty
                                    ? const Center(child: Text('No images found.'))
                                    : GridView.builder(
                                        controller: controller.gridViewScrollController.value,
                                        shrinkWrap: true,
                                        // physics: const AlwaysScrollableScrollPhysics(),
                                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 4,
                                          crossAxisSpacing: 2.0,
                                          mainAxisSpacing: 2.0,
                                        ),
                                        itemCount: controller.photos.storageImagesList.length,
                                        itemBuilder: (context, index) {
                                          AssetEntity assets = controller.photos.storageImagesList[index];
                                          return FutureBuilder<Uint8List?>(
                                              future: assets.thumbnailData,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.done && snapshot.data != null) {
                                                  return GestureDetector(
                                                      onTap: () {
                                                        controller.onImageSelected(assets);
                                                      },
                                                      child: Stack(children: [
                                                        GridTile(
                                                          child: Image.memory(snapshot.data!,
                                                              fit: BoxFit.cover, width: double.infinity, height: double.infinity),
                                                        ),
                                                        Obx(() => controller.photos.isMultipleSelected.value == true &&
                                                                controller.photos.selectedImageAssets.contains(assets)
                                                            ? Container(
                                                                    decoration: BoxDecoration(
                                                                        shape: BoxShape.circle,
                                                                        border: Border.all(color: Colors.white, width: 0.1),
                                                                        color: Colors.blue),
                                                                    padding: EdgeInsets.all(5.sp),
                                                                    child: Icon(Icons.check, size: 12.r))
                                                                .paddingAll(6.sp)
                                                            : const SizedBox.shrink()),
                                                      ]));
                                                } else {
                                                  return const Center(child: CircularProgressIndicator.adaptive());
                                                }
                                              });
                                        }),
                              ).paddingOnly(left: 10.sp, right: 10.sp, top: 10.sp),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
  // String formatter(Duration duration) => [
  //       duration.inMinutes.remainder(60).toString().padLeft(2, '0'),
  //       duration.inSeconds.remainder(60).toString().padLeft(2, '0')
  //     ].join(":");

  // List<Widget> _trimSlider() {
  //   return [
  //     AnimatedBuilder(
  //       animation: Listenable.merge([
  //         _controller,
  //         _controller.video,
  //       ]),
  //       builder: (_, __) {
  //         final int duration = _controller.videoDuration.inSeconds;
  //         final double pos = _controller.trimPosition * duration;

  //         return Padding(
  //           padding: EdgeInsets.symmetric(horizontal: height / 4),
  //           child: Row(children: [
  //             Text(formatter(Duration(seconds: pos.toInt()))),
  //             const Expanded(child: SizedBox()),
  //             AnimatedOpacity(
  //               opacity: _controller.isTrimming ? 1 : 0,
  //               duration: kThemeAnimationDuration,
  //               child: Row(mainAxisSize: MainAxisSize.min, children: [
  //                 Text(formatter(_controller.startTrim)),
  //                 const SizedBox(width: 10),
  //                 Text(formatter(_controller.endTrim)),
  //               ]),
  //             ),
  //           ]),
  //         );
  //       },
  //     ),
  //     Container(
  //       width: MediaQuery.of(context).size.width,
  //       margin: EdgeInsets.symmetric(vertical: height / 4),
  //       child: TrimSlider(
  //         controller: _controller,
  //         height: height,
  //         horizontalMargin: height / 4,
  //         child: TrimTimeline(
  //           controller: _controller,
  //           padding: const EdgeInsets.only(top: 10),
  //         ),
  //       ),
  //     )
  //   ];
  // }
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/widgets/ButtonWidget.dart';

class MediaPostBottomSheet {
  static final CreatePostController controller = Get.find();

  static void showPrivacySettings(BuildContext context) {
    Get.bottomSheet(
      Container(
        padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
        decoration:
            const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(Icons.close, color: Colors.transparent, size: 20.r),
                Text("Privacy Settings", style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                InkWell(
                    onTap: () {
                      Get.back();
                    },
                    radius: 40.r,
                    child: Icon(Icons.close, color: Colors.black, size: 24.r)),
              ],
            ).paddingOnly(bottom: 4.h, left: 8.sp, right: 8.sp),
            Divider(color: Colors.grey.shade300),
            Padding(
              padding: EdgeInsets.only(top: 16.sp, left: 8.sp),
              child: Text("Who can watch this", style: TextStyle(fontSize: 12.sp, color: const Color(0xFF737373), fontWeight: FontWeight.w400)),
            ),
            Obx(() => ListTile(
                  title: Text("Everyone", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  trailing: Radio<Selection>(
                    value: Selection.everyone,
                    groupValue: controller.privacyOption.value,
                    activeColor: const Color(0xFF0A9AAA),
                    onChanged: (value) {
                      if (value != null) {
                        controller.onSelectPrivacy(value);
                      }
                    },
                  ),
                  onTap: () => controller.onSelectPrivacy(Selection.everyone),
                ).paddingOnly(left: 8.sp)),
            Divider(color: Colors.grey.shade300),
            Obx(() => ListTile(
                  title: Text("Only me", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                  contentPadding: EdgeInsets.zero,
                  dense: true,
                  trailing: Radio<Selection>(
                    value: Selection.onlyMe,
                    groupValue: controller.privacyOption.value,
                    activeColor: const Color(0xFF0A9AAA),
                    onChanged: (value) {
                      if (value != null) {
                        controller.onSelectPrivacy(value);
                      }
                    },
                  ),
                  onTap: () => controller.onSelectPrivacy(Selection.onlyMe),
                ).paddingOnly(left: 8.sp)),
            Divider(color: Colors.grey.shade300),
            Obx(() => SwitchListTile(
                  title: Text("Allow Comments", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                  value: controller.isCommentSwitchOn.value,
                  contentPadding: EdgeInsets.zero,
                  activeColor: const Color(0xFFFFFFFF),
                  activeTrackColor: const Color(0xFF0A9AAA),
                  inactiveThumbColor: Colors.white,
                  inactiveTrackColor: Colors.grey,
                  onChanged: (bool value) {
                    controller.toggleSwitch(value);
                  },
                ).paddingOnly(left: 8.sp)),
            SizedBox(height: 24.sp)
          ],
        ),
      ),
      isDismissible: false,
      // ).whenComplete(controller.resetNoodSoundVars);
    );
  }

  static void showStreamQualitySettings(BuildContext context) {
    Get.bottomSheet(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8.sp, vertical: 16.sp),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.close, color: Colors.transparent, size: 20.r),
                  Text("Stream Quality Settings", style: TextStyle(fontSize: 18.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                  InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(Icons.close, color: Colors.black, size: 24.r)),
                ],
              ).paddingOnly(bottom: 4.h, left: 8.sp, right: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("Auto", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: 'Auto',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("360p", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: '360p',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              ListTile(
                title: Text("720p", style: TextStyle(fontSize: 14.sp, color: Colors.black, fontWeight: FontWeight.w500)),
                contentPadding: EdgeInsets.zero,
                dense: true,
                trailing: Radio(
                  value: '720p',
                  groupValue: 'Auto',
                  activeColor: const Color(0xFF0A9AAA),
                  onChanged: (value) {},
                ),
              ).paddingOnly(left: 8.sp),
              Divider(color: Colors.grey.shade300),
              SizedBox(height: 24.sp)
            ],
          ),
        ),
        isDismissible: false
        // ).whenComplete(controller.resetNoodSoundVars);
        );
  }

  static void showAddSoundsBottomSheet(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;

    controller.initSoundCategories();
    Get.bottomSheet(
      Stack(
        children: [
          Container(
            height: Get.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: GetPlatform.isAndroid ? topPadding : kToolbarHeight, width: double.infinity),
                  Container(
                    height: GetPlatform.isAndroid ? 56.sp : kToolbarHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.8, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.close, size: 26.r, color: Colors.transparent),
                        Text("Add Sound", style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                        IconButton(
                            icon: Icon(Icons.close, size: 26.r),
                            color: Colors.black,
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              controller.resetNoodSoundVars();
                              Get.back();
                            })
                      ],
                    ),
                  ).paddingOnly(bottom: 4.sp),
                  Obx(() => TextField(
                        controller: controller.searchController.value,
                        onChanged: (query) => controller.filterMoodMusic(query),
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                                  height: 1.sp,
                                  padding: EdgeInsets.only(right: 15.sp, left: 15.sp, top: 2.sp, bottom: 2.sp),
                                  decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFACACAC)))),
                                  child: const Icon(Icons.search, color: Color(0xFFACACAC)))
                              .paddingOnly(right: 10.sp),
                          hintText: 'Search music/mood',
                          hintStyle: TextStyle(color: const Color(0xFFACACAC), fontSize: 15.sp, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: const BorderSide(color: Color(0xFFACACAC)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: const BorderSide(color: Color(0xFFACACAC)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ).paddingSymmetric(horizontal: 10.sp, vertical: 10.sp)),
                  Obx(
                    () => controller.selectedMoodTitle.isEmpty
                        ? Align(
                                alignment: Alignment.centerLeft,
                                child: Container(
                                    padding: EdgeInsets.all(2.sp),
                                    child: Text("Moods:", style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500))))
                            .paddingOnly(left: 15.sp, top: 10.sp, bottom: 10.sp)
                        : Align(
                            alignment: Alignment.centerLeft,
                            child: GestureDetector(
                              onTap: () {
                                controller.onModeBackPressed();
                              },
                              child: Container(
                                padding: EdgeInsets.all(2.sp),
                                child: Row(
                                  children: [
                                    Icon(Icons.arrow_back_ios, size: 24.r, color: Colors.black),
                                    Text("Moods/${controller.selectedMoodTitle}",
                                        style: TextStyle(color: Colors.black, fontSize: 18.sp, fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              ),
                            )).paddingOnly(left: 15.sp, top: 10.sp, bottom: 10.sp),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 210.sp,
            left: 0.sp,
            right: 0.sp,
            child: SizedBox(
              height: Get.height - 210.sp,
              width: double.infinity,
              child: PageView(
                controller: controller.modePageController.value,
                children: [
                  Obx(
                    () => ListView.builder(
                      shrinkWrap: true,
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemCount: controller.soundCategories.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              leading: Image.asset(controller.soundCategories[index].description, height: 35.sp, width: 25.sp),
                              title: Text(controller.soundCategories[index].title,
                                  style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400)),
                              trailing: Icon(Icons.arrow_forward_ios, color: Colors.black, size: 24.r),
                              onTap: () => controller.onMode1ItemSelected(index, controller.soundCategories[index]),
                            ),
                            Container(height: 0.8, color: Colors.black12).paddingSymmetric(horizontal: 15.sp),
                          ],
                        );
                      },
                    ),
                  ),
                  Obx(
                    () => controller.audioDataModel2.isEmpty
                        ? const SizedBox.shrink()
                        : ListView.builder(
                            shrinkWrap: true,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemCount: controller.audioDataModel2.length,
                            itemBuilder: (context, index) {
                              String url = controller.audioDataModel2[index].audio;
                              return Column(
                                children: [
                                  Obx(() {
                                    bool isPlaying = controller.audio.isCurrentlyPlaying(url);
                                    bool isLoading = controller.audio.isAudioLoading.value && controller.audio.currentTrack.value == url;
                                    return ListTile(
                                        selectedColor: const Color(0xFF777777),
                                        dense: false,
                                        leading: Image.asset(controller.audioDataModel2[index].icon, height: 51.sp, width: 51.sp),
                                        title: Text(controller.audioDataModel2[index].title,
                                            style: TextStyle(color: Colors.black, fontSize: 12.sp, fontWeight: FontWeight.w600)),
                                        subtitle: Text(controller.audioDataModel2[index].description,
                                            style: TextStyle(color: const Color(0xFF757575), fontSize: 10.sp, fontWeight: FontWeight.w600)),
                                        onTap: () => controller.onMusicItemSelected(controller.audioDataModel2[index]),
                                        trailing: isLoading
                                            ? Container(
                                                height: 20.sp,
                                                width: 20.sp,
                                                decoration: const BoxDecoration(color: Colors.black87, shape: BoxShape.circle),
                                                padding: EdgeInsets.all(3.sp),
                                                child: const CircularProgressIndicator.adaptive(backgroundColor: Colors.white))
                                            : IconButton(
                                                color: Colors.black87,
                                                padding: EdgeInsets.all(4.sp),
                                                constraints: BoxConstraints(maxHeight: 30.sp, maxWidth: 30.sp),
                                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black87)),
                                                icon: Icon(isPlaying ? Icons.pause_outlined : Icons.play_arrow_rounded,
                                                    color: Colors.white, size: 18.r),
                                                isSelected: isPlaying,
                                                onPressed: () {
                                                  log("Tapped AUDIO URL ${controller.audioDataModel2[index].audio}");
                                                  controller.audio.playAudio(controller.audioDataModel2[index].audio);
                                                }));
                                  }),
                                  Container(height: 0.8, color: Colors.black12).paddingSymmetric(horizontal: 15.sp),
                                ],
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      isDismissible: false,
      isScrollControlled: true,
    ).whenComplete(() {
      controller.processVideoData();
    });
  }

  static void showAddHashtagBottomSheet(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    log(" Get.statusBarHeight ${Get.statusBarHeight} TOP $topPadding");
    controller.initHashtagData();
    Get.bottomSheet(
      Stack(
        children: [
          Container(
            height: Get.height,
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: GetPlatform.isAndroid ? topPadding : kToolbarHeight, width: double.infinity),
                  Container(
                    height: GetPlatform.isAndroid ? 56.sp : kToolbarHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.8, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Obx(() => controller.selectedHashtags.isNotEmpty
                            ? TextButton(
                                onPressed: () {
                                  controller.selectedHashtags.clear();
                                },
                                child: Text("Clear", style: TextStyle(color: const Color(0xFF008EFF), fontSize: 15.sp, fontWeight: FontWeight.w400)))
                            : TextButton(
                                onPressed: () {},
                                child: Text("Done", style: TextStyle(color: Colors.transparent, fontSize: 15.sp, fontWeight: FontWeight.w400)))),
                        Text("#Hashtags", style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                        Obx(() => controller.selectedHashtags.isNotEmpty
                            ? TextButton(
                                onPressed: () {
                                  Get.back();
                                },
                                child: Text("Done", style: TextStyle(color: const Color(0xFF008EFF), fontSize: 15.sp, fontWeight: FontWeight.w400)))
                            : IconButton(
                                icon: Icon(Icons.close, size: 26.r),
                                color: Colors.black,
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                                onPressed: () {
                                  Get.back();
                                }))
                      ],
                    ),
                  ).paddingOnly(bottom: 4.sp),
                  Obx(() => TextField(
                        controller: controller.searchController.value,
                        onChanged: (query) => controller.filterHashtagData(query),
                        style: TextStyle(color: Colors.black87, fontSize: 14.sp, fontWeight: FontWeight.w400),
                        decoration: InputDecoration(
                          prefixIcon: Container(
                                  height: 1.sp,
                                  padding: EdgeInsets.only(right: 15.sp, left: 15.sp, top: 2.sp, bottom: 2.sp),
                                  decoration: const BoxDecoration(border: Border(right: BorderSide(color: Color(0xFFACACAC)))),
                                  child: const Icon(Icons.search, color: Color(0xFFACACAC)))
                              .paddingOnly(right: 10.sp),
                          hintText: 'Search hashtags',
                          hintStyle: TextStyle(color: const Color(0xFFACACAC), fontSize: 15.sp, fontWeight: FontWeight.w400),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: const BorderSide(color: Color(0xFFACACAC)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.sp),
                            borderSide: const BorderSide(color: Color(0xFFACACAC)),
                          ),
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                        ),
                      ).paddingSymmetric(horizontal: 10.sp, vertical: 10.sp)),
                ],
              ),
            ),
          ),
          Positioned(
              top: 165.sp,
              left: 0.sp,
              right: 0.sp,
              child: SizedBox(
                height: Get.height - 165.sp,
                width: double.infinity,
                child: Obx(
                  () => ListView.builder(
                    shrinkWrap: true,
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: controller.hashtagDataList.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Obx(
                            () => ListTile(
                                leading: Obx(() => !controller.selectedHashtags.contains(controller.hashtagDataList[index])
                                    ? Container(
                                        width: 21.sp,
                                        height: 21.sp,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
                                        child: Icon(Icons.check, size: 12.r, color: Colors.transparent))
                                    : Container(
                                        width: 21.sp,
                                        height: 21.sp,
                                        decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF0A9AAA)),
                                        child: Icon(Icons.check, size: 12.r, color: Colors.white))),
                                title: Text(controller.hashtagDataList[index].title,
                                    style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w400)),
                                onTap: () {
                                  controller.onSelectedHastag(index);
                                }),
                          ),
                          Container(height: 0.8, color: Colors.black12).paddingSymmetric(horizontal: 15.sp),
                        ],
                      );
                    },
                  ),
                ),
              )),
        ],
      ),
      isDismissible: false,
      isScrollControlled: true,
      // ).whenComplete(controller.resetNoodSoundVars);
    );
  }

  static void showAddDescriptionBottomSheet(BuildContext context) {
    double topPadding = MediaQuery.of(context).padding.top;
    controller.descController.value.clear();

    Get.bottomSheet(
      Stack(
        children: [
          Container(
            height: Get.height, // Full screen height
            color: Colors.white,
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: GetPlatform.isAndroid ? topPadding : kToolbarHeight, width: double.infinity),
                  Container(
                    height: GetPlatform.isAndroid ? 56.sp : kToolbarHeight,
                    width: double.infinity,
                    decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 0.8, color: Colors.black12))),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                            icon: Icon(Icons.close, size: 26.r),
                            color: Colors.black,
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white)),
                            onPressed: () {
                              Get.back();
                            }),
                        Text("Description", style: TextStyle(color: Colors.black, fontSize: 15.sp, fontWeight: FontWeight.w500)),
                        IconButton(
                            icon: Icon(Icons.close, size: 26.r),
                            color: Colors.transparent,
                            style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.transparent)),
                            onPressed: () {})
                      ],
                    ),
                  ).paddingOnly(bottom: 4.sp),
                  Obx(() => TextField(
                          controller: controller.descController.value,
                          cursorColor: Colors.black87,
                          decoration: InputDecoration(
                            hintText: "Enter Description",
                            hintStyle: TextStyle(color: const Color(0xFFB0B1B2), fontSize: 15.sp, fontWeight: FontWeight.w500),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.sp),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          scrollPadding: const EdgeInsets.all(20.0),
                          keyboardType: TextInputType.multiline,
                          maxLines: 30,
                          autofocus: false,
                          style: TextStyle(color: Colors.black87, fontSize: 15.sp, fontWeight: FontWeight.w500))
                      .paddingSymmetric(horizontal: 15.sp)),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 30.sp,
            left: 0.sp,
            right: 0.sp,
            child: ButtonWidget(
              label: 'Save',
              radius: 10.sp,
              height: 47.sp,
              width: double.infinity,
              color: const Color(0xFF0A9AAA),
              textColor: const Color(0xFFD3D3D3),
              onPressed: () {
                controller.video.isVideoPlaying.value = false;
                FocusManager.instance.primaryFocus?.unfocus();
                log("Save");
              },
            ).paddingSymmetric(horizontal: 15.sp),
          )
        ],
      ),
      isScrollControlled: true,
    );
  }
}

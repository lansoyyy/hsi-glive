// ignore_for_file: null_check_always_fails, unnecessary_null_comparison, prefer_if_null_operators

import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/AppColors.dart';
import 'package:glive/models/app/LiveStreamState.dart';
import 'package:glive/modules/live/controller/camera_live_controller.dart';
import 'package:glive/modules/live/controller/video_live_controller.dart';
import 'package:glive/modules/live/views/video_preview_view.dart';
import 'package:glive/modules/live/widgets/live_bottom_sheet.dart';
import 'package:glive/modules/live/widgets/live_dialogs.dart';
import 'package:glive/modules/live/widgets/multi_live_widget.dart';
import 'package:glive/widgets/AppPageBackground.dart';
import 'package:glive/widgets/ButtonWidget.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';

class LiveView extends StatefulWidget {
  const LiveView({super.key});

  @override
  State<LiveView> createState() => _LiveViewState();
}

class _LiveViewState extends State<LiveView> {
  final VideoLiveController videoLiveController = Get.put(VideoLiveController());
  static const String server = "rtmp://broadcast.ksmiguel.com/live/";
  static const String streamKey = "glivetest";

  // late CameraController cameraController;

  late final CameraLiveStreamController cameraLiveStreamController;

  late StreamSubscription<LiveStreamState> streamSubscription;

  late LiveStreamState _currentState;

  String status = 'Idle';
  bool audioSessionConfigured = false;
  @override
  void initState() {
    super.initState();
    initCamAudio();
    // _initPermissionAndAuduiSession();
  }

  // void _initPermissionAndAuduiSession() async {
  //   cameraController = CameraController(cameras[0], ResolutionPreset.veryHigh);
  //   cameraController.initialize().then((_) {
  //     if (!mounted) {
  //       return;
  //     }
  //     setState(() {});
  //   }).catchError((Object e) async {
  //     if (e is CameraException) {
  //       switch (e.code) {
  //         case 'CameraAccessDenied':
  //           await Permission.camera.request();
  //           break;
  //         default:
  //           // Handle other errors here.
  //           break;
  //       }
  //     }
  //   });
  //   await Permission.microphone.request();
  //   audioSessionConfigured = await configureAudioSession();
  //   setState(() {});
  //   initCamAudio();
  // }
  void _init() async {
    await Permission.camera.request();
    await Permission.microphone.request();

    audioSessionConfigured = await configureAudioSession();

    setState(() {});
  }

  void initCamAudio() async {
    _init();
    cameraLiveStreamController = CameraLiveStreamController(server, streamKey)..initialize();
    streamSubscription = cameraLiveStreamController.stateStream.listen((event) {
      if (_currentState != event) {
        setState(() {
          _currentState = event;
        });
      }
    });

    _currentState = cameraLiveStreamController.state;
  }

  @override
  void dispose() {
    streamSubscription.cancel();
    cameraLiveStreamController.dispose();
    // cameraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppPageBackground(
        child: Stack(children: [
          _currentState.status == LiveStreamStatus.idle
              ? Container(
                  width: size.width,
                  height: size.height,
                  decoration: const BoxDecoration(color: Colors.black),
                  child: const Center(child: CircularProgressIndicator.adaptive()),
                )
              : _currentState.status == LiveStreamStatus.connected ||
                      _currentState.status == LiveStreamStatus.initialized ||
                      _currentState.status == LiveStreamStatus.living
                  ? Obx(() => videoLiveController.selectedtedLive.value == 0 || videoLiveController.selectedtedLive.value == 2
                      ? Positioned(
                          top: 0.sp,
                          bottom: 60.sp,
                          left: 0.sp,
                          right: 0.sp,
                          // child: CameraPreview(cameraController),
                          child: VideoPreviewView(textureManager: cameraLiveStreamController, state: _currentState),
                        )
                      : Positioned(
                          top: 240.sp,
                          right: 0.sp,
                          left: 0.sp,
                          // child: MultiLiveWidget(
                          //   cameraController: cameraController,
                          // ),
                          child: MultiLiveWidget(textureManager: cameraLiveStreamController, state: _currentState),
                        ))
                  : const Center(
                      child: Text("Live stream stopped or disconnected."),
                    ),
          Positioned(
            top: 55.sp,
            left: 16.sp,
            right: 16.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 34.sp,
                      height: 34.sp,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white24,
                      ),
                      child: Center(
                        child: IconButton(
                          icon: const Icon(
                            Icons.arrow_back,
                            size: 16,
                          ),
                          color: Colors.white,
                          onPressed: () async {
                            bool resultValue = await LiveDialogs.showDiscardLiveDialog(context);
                            if (resultValue == true) {
                              if (_currentState.status == LiveStreamStatus.connected ||
                                  _currentState.status == LiveStreamStatus.initialized ||
                                  _currentState.status == LiveStreamStatus.living) {
                                Get.back();
                              }
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 4.sp,
                    ),
                    Container(
                      height: 42.sp,
                      width: 175.sp,
                      decoration: BoxDecoration(
                          color: const Color(0xFF222222).withOpacity(0.7),
                          borderRadius: BorderRadius.circular(24.sp),
                          border: Border.all(color: Colors.white70, width: 0.1)),
                      padding: const EdgeInsets.all(4),
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/ivanasexy.png',
                            ),
                          ),
                          SizedBox(
                            width: 4.sp,
                          ),
                          const Text(
                            'Ivanakanatalaga',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                InkWell(
                  onTap: () {
                    videoLiveController.isDropdownOpen.value = !videoLiveController.isDropdownOpen.value;
                  },
                  child: Container(
                    width: 140.sp,
                    padding: EdgeInsets.only(top: 8.0.sp, bottom: 8.sp, left: 8.sp),
                    decoration: BoxDecoration(
                        color: const Color(0xFF000000).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white70, width: 0.3)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Content Category',
                          style: TextStyle(color: Colors.white, fontSize: 11.sp, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.arrow_drop_down, color: Colors.white, size: 20.r),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 115.sp,
            left: 36.sp,
            right: 36.sp,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(onTap: () {}, child: const Icon(Icons.star, color: Colors.white)),
                InkWell(
                    onTap: () {
                      // cameraController.setFlashMode(FlashMode.auto);
                    },
                    child: const Icon(Icons.flash_on, color: Colors.white)),
                InkWell(
                    onTap: () async {
                      await cameraLiveStreamController.switchCamera();
                    },
                    child: const Icon(Icons.camera_alt, color: Colors.white)),
                Obx(() => videoLiveController.isDropdownOpen.value == true
                    ? const Icon(Icons.settings, color: Colors.transparent)
                    : InkWell(onTap: () {}, child: const Icon(Icons.mic_none_sharp, color: Colors.white))),
                Obx(() => videoLiveController.isDropdownOpen.value == true
                    ? const Icon(Icons.settings, color: Colors.transparent)
                    : InkWell(
                        onTap: () {
                          LiveBottomSheet.showStreamQualitySettings(context);
                        },
                        child: const Icon(Icons.settings, color: Colors.white))),
              ],
            ),
          ),
          Obx(() => videoLiveController.isDropdownOpen.value == true
              ? Positioned(
                  top: 87.sp,
                  right: 16.sp,
                  child: Container(
                    width: 145.sp,
                    padding: EdgeInsets.symmetric(horizontal: 12.sp, vertical: 8.sp),
                    decoration: BoxDecoration(
                        color: const Color(0xFF000000).withOpacity(0.3),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.white70, width: 0.3)),
                    child: ListView.builder(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        itemCount: videoLiveController.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return InkWell(
                            onTap: () {
                              if (videoLiveController.addCategories.contains(videoLiveController.categories[index])) {
                                videoLiveController.isDropdownOpen.value = false;
                                showToast('Selected content category is already added.',
                                    textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                                    textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
                                    position: ToastPosition.bottom);
                              } else {
                                videoLiveController.selectedCategory.value = videoLiveController.categories[index]["label"];
                                videoLiveController.icons = videoLiveController.categories[index]["icon"];
                                videoLiveController.isDropdownOpen.value = false;
                                videoLiveController.addCategories.add(videoLiveController.categories[index]);
                                showToast('You added ${videoLiveController.selectedCategory.value} Category as your content.',
                                    textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
                                    textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
                                    position: ToastPosition.bottom);
                              }
                            },
                            child: Container(
                              width: 145.sp,
                              padding: EdgeInsets.symmetric(vertical: 6.0.sp, horizontal: 2.sp),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(videoLiveController.categories[index]["icon"], color: Colors.white, size: 16.r),
                                  SizedBox(width: 8.w),
                                  Text(
                                    videoLiveController.categories[index]['label'],
                                    style: TextStyle(color: Colors.white, fontSize: 12.sp, fontWeight: FontWeight.w300),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  ),
                )
              : const SizedBox.shrink()),
          Positioned(
            top: 170.sp,
            right: 0,
            left: 0,
            child: Align(
              alignment: Alignment.center,
              child: Container(
                width: 115.sp,
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                    color: const Color(0xFF000000).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(24.sp),
                    border: Border.all(color: Colors.white70, width: 0.3)),
                child: Row(
                  children: [
                    Icon(Icons.circle, color: Colors.red, size: 16.r),
                    SizedBox(width: 4.w),
                    Text(
                      'Preview Live',
                      style: TextStyle(color: Colors.white, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
            ),
          ),

          //----------BOTTOM-----------//
          Obx(
            () => Positioned(
              bottom: videoLiveController.selectedtedLive.value == 0 || videoLiveController.selectedtedLive.value == 2 ? 290.sp : 335.sp,
              left: 16.sp,
              right: 16.sp,
              child: Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    LiveBottomSheet.showPrivacySettings(context);
                  },
                  child: Container(
                    width: 180.sp,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8),
                    decoration: BoxDecoration(
                        color: const Color(0xFF000000).withOpacity(0.2),
                        border: Border.all(color: Colors.white70, width: 0.1),
                        borderRadius: BorderRadius.circular(24.sp)),
                    child: Row(
                      children: [
                        Icon(Icons.circle, color: Colors.white, size: 16.r),
                        SizedBox(width: 8.w),
                        Text(
                          'Post * Everyone can view',
                          style: TextStyle(color: Colors.white, fontSize: 10.sp, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Obx(() => Positioned(
                bottom: videoLiveController.selectedtedLive.value == 0 || videoLiveController.selectedtedLive.value == 2 ? 135.sp : 185.sp,
                left: 16.sp,
                right: 16.sp,
                child: Container(
                  height: 140.sp,
                  width: double.infinity,
                  decoration: BoxDecoration(color: const Color(0xFF000000).withOpacity(0.3), borderRadius: BorderRadius.circular(10.sp)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          log("TAPPED ADD TTILE");
                        },
                        child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Text(
                              'Add a title to chat',
                              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                            )).paddingOnly(top: 20.sp, left: 20.sp),
                      ),
                      GestureDetector(
                        onTap: () {
                          log("TAPPED DESCRIPTION");
                        },
                        child: Container(
                            width: double.infinity,
                            color: Colors.transparent,
                            child: Text(
                              'Description',
                              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                            )).paddingOnly(top: 15.sp, left: 20.sp),
                      ),
                      SizedBox(height: 25.h),
                      Container(
                        height: .1.h,
                        width: double.infinity,
                        color: Colors.white54,
                      ),
                      SizedBox(height: 8.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            height: 25.sp,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white, width: 0.2),
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                            child: Center(
                              child: Text(
                                '#Sexy Lady',
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ).paddingOnly(right: 8.sp),
                          Container(
                            height: 25.sp,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white, width: 0.2),
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                            child: Center(
                              child: Text(
                                '#game',
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ).paddingOnly(right: 8.sp),
                          Container(
                            height: 25.sp,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white, width: 0.2),
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                            child: Center(
                              child: Text(
                                '#Sharinglife',
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ).paddingOnly(right: 8.sp),
                          Container(
                            height: 25.sp,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white, width: 0.2),
                                borderRadius: BorderRadius.circular(15.sp)),
                            padding: EdgeInsets.symmetric(horizontal: 15.sp, vertical: 2.sp),
                            child: Center(
                              child: Text(
                                '#lifestyle',
                                style: TextStyle(fontSize: 10.sp, fontWeight: FontWeight.w400, color: Colors.white),
                              ),
                            ),
                          ).paddingOnly(right: 8.sp),
                          Container(
                            height: 25.sp,
                            width: 25.sp,
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                border: Border.all(color: Colors.white60, width: 0.1),
                                // borderRadius: BorderRadius.circular(15.sp),
                                shape: BoxShape.circle),
                            padding: EdgeInsets.symmetric(horizontal: 2.sp, vertical: 0.sp),
                            child: Center(
                              child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 16.r),
                            ),
                          ),
                        ],
                      ).paddingSymmetric(horizontal: 8.sp),
                    ],
                  ),
                ),
              )),
          Positioned(
            bottom: 70.sp,
            left: 15.sp,
            right: 15.sp,
            child: ButtonWidget(
              label: 'Go Live',
              radius: 10.sp,
              height: 47.sp,
              color: const Color(0xFF0A9AAA),
              textColor: const Color(0xFFD3D3D3),
              onPressed: () {
                LiveBottomSheet.showAddHashtagBottomSheet(context);
              },
            ),
          ),

          Obx(
            () => videoLiveController.selectedtedLive.value == 0 || videoLiveController.selectedtedLive.value == 2
                ? const SizedBox.shrink()
                : Positioned(
                    bottom: 140.sp,
                    left: 36.sp,
                    right: 36.sp,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Obx(() => InkWell(
                            onTap: () {
                              videoLiveController.multiLiveCounte.value = 4;
                              videoLiveController.multiLiveAspectRatio.value = 1;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24.sp),
                                    border: Border.all(
                                        color: videoLiveController.multiLiveCounte.value == 4 ? Colors.white70 : Colors.transparent, width: 0.3)),
                                height: 32.sp,
                                width: 72.sp,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(Icons.chair, color: Colors.white, size: 20.r).paddingOnly(right: 6.sp),
                                  Text(
                                    '4',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  )
                                ])))),
                        Obx(() => InkWell(
                            onTap: () {
                              videoLiveController.multiLiveCounte.value = 6;
                              videoLiveController.multiLiveAspectRatio.value = 1.31;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24.sp),
                                    border: Border.all(
                                        color: videoLiveController.multiLiveCounte.value == 6 ? Colors.white70 : Colors.transparent, width: 0.3)),
                                height: 32.sp,
                                width: 72.sp,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(Icons.chair, color: Colors.white, size: 20.r).paddingOnly(right: 6.sp),
                                  Text('6', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white))
                                ])))),
                        Obx(() => InkWell(
                            onTap: () {
                              videoLiveController.multiLiveCounte.value = 9;
                              videoLiveController.multiLiveAspectRatio.value = 1.0008;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24.sp),
                                    border: Border.all(
                                        color: videoLiveController.multiLiveCounte.value == 9 ? Colors.white70 : Colors.transparent, width: 0.3)),
                                height: 32.sp,
                                width: 72.sp,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(Icons.chair, color: Colors.white, size: 20.r).paddingOnly(right: 6.sp),
                                  Text(
                                    '9',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  )
                                ])))),
                        Obx(() => InkWell(
                            onTap: () {
                              videoLiveController.multiLiveCounte.value = 12;
                              videoLiveController.multiLiveAspectRatio.value = 1;
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: const Color(0xFF000000).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(24.sp),
                                    border: Border.all(
                                        color: videoLiveController.multiLiveCounte.value == 12 ? Colors.white70 : Colors.transparent, width: 0.3)),
                                height: 32.sp,
                                width: 72.sp,
                                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                                  Icon(Icons.chair, color: Colors.white, size: 20.r).paddingOnly(right: 6.sp),
                                  Text(
                                    '12',
                                    style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500, color: Colors.white),
                                  )
                                ])))),
                      ],
                    ),
                  ),
          ),
          Positioned(
            bottom: 0.sp,
            left: 0.sp,
            right: 0.sp,
            child: Container(
              height: 65.sp,
              decoration: BoxDecoration(color: const Color(0xFF000000).withOpacity(0.3)),
              child: Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    videoLiveController.selectedtedLive.value == 0
                        ? InkWell(
                            child: Container(
                                height: 32.sp,
                                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    gradient: const LinearGradient(
                                        colors: [AppColors.buttonGradEndColor, AppColors.buttonGradStartColor],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                child: Center(
                                    child: Text(
                                  'LIVE',
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
                                ))),
                          )
                        : InkWell(
                            onTap: () {
                              videoLiveController.selectedtedLive.value = 0;
                            },
                            child: Text('LIVE', style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)))),
                    videoLiveController.selectedtedLive.value == 1
                        ? InkWell(
                            child: Container(
                                height: 32.sp,
                                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    gradient: const LinearGradient(
                                        colors: [AppColors.buttonGradEndColor, AppColors.buttonGradStartColor],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                child: Center(
                                    child: Text(
                                  'Multi-guest LIVE',
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
                                ))),
                          )
                        : InkWell(
                            onTap: () {
                              videoLiveController.selectedtedLive.value = 1;
                            },
                            child: Text('Multi-guest LIVE',
                                style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)))),
                    videoLiveController.selectedtedLive.value == 2
                        ? InkWell(
                            child: Container(
                                height: 32.sp,
                                padding: EdgeInsets.symmetric(horizontal: 12.sp),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30.sp),
                                    gradient: const LinearGradient(
                                        colors: [AppColors.buttonGradEndColor, AppColors.buttonGradStartColor],
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight)),
                                child: Center(
                                    child: Text(
                                  'Game LIVE',
                                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w500, color: Colors.black),
                                ))),
                          )
                        : InkWell(
                            onTap: () {
                              videoLiveController.selectedtedLive.value = 2;
                            },
                            child: Text(
                              'Game LIVE',
                              style: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w400, color: const Color(0xFFD3D3D3)),
                            )),
                  ],
                ).paddingOnly(left: 15.sp, top: 3.sp, right: 15.sp, bottom: 15.sp),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

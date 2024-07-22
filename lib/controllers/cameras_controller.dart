// ignore_for_file: unnecessary_null_comparison, unused_local_variable

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/Assets.dart';
import 'package:glive/controllers/audios_controller.dart';
import 'package:glive/controllers/videos_controller.dart';
import 'package:glive/main.dart';
import 'package:glive/routes/AppRoutes.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class CamerasController extends GetxController with GetTickerProviderStateMixin {
  RxInt selectedPostPageIndex = 0.obs;
  RxBool enableAudio = true.obs;
  Timer? timer;
  RxBool isRecording = false.obs;
  RxBool isRecorded = false.obs;
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isInitializedCamera = false.obs;
  late CameraController controllers;

  XFile? imageFile;
  XFile? videoFile;
  // Rx<File?> thumbnailFile = Rx<File?>(null);

  RxDouble minAvailableExposureOffset = 0.0.obs;
  RxDouble maxAvailableExposureOffset = 0.0.obs;
  RxDouble currentExposureOffset = 0.0.obs;
  late AnimationController flashModeControlRowAnimationController;
  late Animation<double> flashModeControlRowAnimation;
  late AnimationController exposureModeControlRowAnimationController;
  late Animation<double> exposureModeControlRowAnimation;
  late AnimationController focusModeControlRowAnimationController;
  late Animation<double> focusModeControlRowAnimation;
  // Counting pointers (number of user fingers on screen)
  RxInt pointers = 0.obs;
  RxInt cameraIndex = 0.obs;
  RxInt recordDuration = 30.obs;
  RxDouble progressDuration = 0.0.obs;
  RxInt elapsed = 0.obs;

  RxDouble minAvailableZoom = 1.0.obs;
  RxDouble maxAvailableZoom = 1.0.obs;
  RxDouble currentScale = 1.0.obs;
  RxDouble baseScale = 1.0.obs;

  PermissionStatus? cameraPermissionStatus;
  PermissionStatus? microphonePermissionStatus;
  PermissionStatus? storagePermissionStatus;

  RxBool isCameraGranted = false.obs;
  RxBool isMicrophoneGranted = false.obs;
  RxBool isStorageGranted = false.obs;
  RxBool isFileEmpty = true.obs;
  RxBool isVideoFile = false.obs;
  RxBool isImageFile = false.obs;
  RxString videoPath = "".obs;
  RxInt fileCounter = 1.obs;
  RxString thumbnailDataPath = "".obs;

  @override
  void onInit() async {
    super.onInit();
    saveThumbnailImage();
    log("Init CamerasController ");
  }

  Future<void> checkAndRequestPermission() async {
    cameraPermissionStatus = await Permission.camera.status;

    log("cameraPermissionStatus $cameraPermissionStatus");
    if (cameraPermissionStatus!.isDenied) {
      isCameraGranted.value = false;
    } else if (cameraPermissionStatus!.isPermanentlyDenied) {
      isCameraGranted.value = false;
    } else if (cameraPermissionStatus!.isGranted) {
      isCameraGranted.value = true;
      await initializeCamera(cameras.first);
    }
  }

  void initAnimationControllers() {
    flashModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    flashModeControlRowAnimation = CurvedAnimation(
      parent: flashModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    exposureModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    exposureModeControlRowAnimation = CurvedAnimation(
      parent: exposureModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
    focusModeControlRowAnimationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    focusModeControlRowAnimation = CurvedAnimation(
      parent: focusModeControlRowAnimationController,
      curve: Curves.easeInCubic,
    );
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controllers != null) {
      isFrontCamera.value = true;
      log("camere dle null");
      return controllers.setDescription(cameraDescription);
    } else {
      log("camere  null");
      isFrontCamera.value = false;
      return initializeCamera(cameraDescription);
    }
  }

  Future<void> initializeCamera(CameraDescription description) async {
    try {
      controllers = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: enableAudio.value,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      log("WEEE");
      log("WEEE INDEX ${cameraIndex.value}");
      controllers.addListener(() {
        if (controllers.value.hasError) {
          if (Get.context!.mounted) {
            update();
          }
          showInSnackBar('Camera error ${controllers.value.errorDescription}');
        }
      });
      await controllers.initialize().then((value) => isInitializedCamera.value = true);
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                controllers.getMinExposureOffset().then((double value) => minAvailableExposureOffset.value = value),
                controllers.getMaxExposureOffset().then((double value) => maxAvailableExposureOffset.value = value)
              ]
            : <Future<Object?>>[],
        controllers.getMaxZoomLevel().then((double value) => maxAvailableZoom.value = value),
        controllers.getMinZoomLevel().then((double value) => minAvailableZoom.value = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          isCameraGranted.value = false;
          showInSnackBar('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          isCameraGranted.value = false;
          showInSnackBar('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
        case 'AudioAccessDenied':
          isMicrophoneGranted.value = false;
          showInSnackBar('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          isMicrophoneGranted.value = false;
          showInSnackBar('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          isMicrophoneGranted.value = false;
          showInSnackBar('Audio access is restricted.');
        default:
          _showCameraException(e);
          break;
      }
    }
    if (Get.context!.mounted) {
      isCameraGranted.value = true;
      isMicrophoneGranted.value = true;
      update();
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) async {
      if (Get.context!.mounted) {
        imageFile = file;
        Get.find<VideosController>().isInitialized.value = false;
        Get.find<VideosController>().cachedVideoPlayerPlusController?.dispose();
        Get.find<VideosController>().cachedVideoPlayerPlusController = null;
        if (file != null) {
          isFileEmpty.value = false;
          isImageFile.value = true;
          update();
          log("Picture saved to ${file.path}");
        }
      }
      await Future.delayed(const Duration(milliseconds: 800)).then((value) {
        disposeCamera();
        Get.back();
        Get.toNamed(AppRoutes.MEDIAPOST);
      });
    });
  }

  Future<void> startVideoRecording(int duration) async {
    final CameraController cameraController = controllers;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }
    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }
    try {
      await Get.find<AudioController>().audioPlayer.play(AssetSource(Assets.videoStart));
      await cameraController.startVideoRecording();

      isRecording.value = true;
      timer?.cancel();
      timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
        if (elapsed.value < recordDuration.value) {
          elapsed.value++;
          progressDuration.value = elapsed.value / recordDuration.value;
        } else {
          if (isRecording.value) {
            timer.cancel();
            await stopVideoRecording();
            update();
          }
        }
      });
      log("DURATION ${recordDuration.value}");
    } on CameraException catch (e) {
      _showCameraException(e);
      return;
    }
  }

  Future<XFile?> stopVideoRecording() async {
    final CameraController cameraController = controllers;
    isRecording.value = false;
    isRecorded.value = true;
    isFileEmpty.value = false;
    isVideoFile.value = true;
    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }
    try {
      await Get.find<AudioController>().audioPlayer.play(AssetSource(Assets.videoStop));
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    final CameraController cameraController = controllers;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.pauseVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> resumeVideoRecording() async {
    final CameraController cameraController = controllers;

    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return;
    }

    try {
      await cameraController.resumeVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void onSetFlashModeButtonPressed(FlashMode mode) async {
    setFlashMode(mode).then((_) {
      if (Get.context!.mounted) {
        update();
      }
      if (mode == FlashMode.torch) {
        isFlashOn.value = true;
        onFlashModeButtonPressed();
      } else {
        isFlashOn.value = false;
      }
      showInSnackBar('Flash mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setFlashMode(FlashMode mode) async {
    if (controllers == null) {
      return;
    }

    try {
      await controllers.setFlashMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void onSetExposureModeButtonPressed(ExposureMode mode) {
    setExposureMode(mode).then((_) {
      if (Get.context!.mounted) {
        update();
      }
      showInSnackBar('Exposure mode set to ${mode.toString().split('.').last}');
    });
  }

  Future<void> setExposureMode(ExposureMode mode) async {
    final CameraController cameraController = controllers;

    if (cameraController == null) {
      return;
    }
    try {
      await cameraController.setExposureMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  Future<void> setExposureOffset(double offset) async {
    final CameraController cameraController = controllers;

    if (cameraController == null) {
      return;
    }
    currentExposureOffset.value = offset;
    try {
      offset = await cameraController.setExposureOffset(offset);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void onSetFocusModeButtonPressed(FocusMode mode) {
    setFocusMode(mode).then((_) {
      if (Get.context!.mounted) {
        update();
      }
      showInSnackBar('Focus mode set to ${mode.toString().split('.').last}');
    });
  }

  void onVideoRecordButtonPressed() {
    startVideoRecording(recordDuration.value).then((_) {
      if (Get.context!.mounted) {
        update();
      }
    });
  }

  Future<void> onPausePreviewButtonPressed() async {
    final CameraController cameraController = controllers;

    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }

    if (cameraController.value.isPreviewPaused) {
      await cameraController.resumePreview();
    } else {
      await cameraController.pausePreview();
    }

    if (Get.context!.mounted) {
      update();
    }
  }

  Future<void> setFocusMode(FocusMode mode) async {
    final CameraController cameraController = controllers;

    if (cameraController == null) {
      return;
    }
    try {
      await cameraController.setFocusMode(mode);
    } on CameraException catch (e) {
      _showCameraException(e);
      rethrow;
    }
  }

  void onPauseButtonPressed() {
    pauseVideoRecording().then((_) {
      if (Get.context!.mounted) {
        update();
      }
      showInSnackBar('Video recording paused');
    });
  }

  void onResumeButtonPressed() {
    resumeVideoRecording().then((_) {
      if (Get.context!.mounted) {
        update();
      }
      showInSnackBar('Video recording resumed');
    });
  }

  void onStopButtonPressed() {
    stopVideoRecording().then((XFile? file) {
      if (Get.context!.mounted) {
        update();
      }
      if (file != null) {
        timer?.cancel();
        // showInSnackBar('Video recorded to ${file.path.split('/').last}');
        videoFile = file;
        videoPath.value = videoFile!.path;
        update();
        Get.find<VideosController>().startVideoPlayer(videoFile, imageFile);
        generateThumbnailData();
      }
    });
  }

  void onFlashModeButtonPressed() {
    if (flashModeControlRowAnimationController.value == 1) {
      flashModeControlRowAnimationController.reverse();
    } else {
      flashModeControlRowAnimationController.forward();
      exposureModeControlRowAnimationController.reverse();
      focusModeControlRowAnimationController.reverse();
    }
  }

  void onExposureModeButtonPressed() {
    if (exposureModeControlRowAnimationController.value == 1) {
      exposureModeControlRowAnimationController.reverse();
    } else {
      exposureModeControlRowAnimationController.forward();
      flashModeControlRowAnimationController.reverse();
      focusModeControlRowAnimationController.reverse();
    }
  }

  void onFocusModeButtonPressed() {
    if (focusModeControlRowAnimationController.value == 1) {
      focusModeControlRowAnimationController.reverse();
    } else {
      focusModeControlRowAnimationController.forward();
      flashModeControlRowAnimationController.reverse();
      exposureModeControlRowAnimationController.reverse();
    }
  }

  void toggleCameraPosition(CameraDescription? description) {
    final lensDirection = description!.lensDirection;
    CameraDescription newDescription;
    if (lensDirection == CameraLensDirection.front) {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.back);
    } else {
      newDescription = cameras.firstWhere((description) => description.lensDirection == CameraLensDirection.front);
    }

    if (newDescription != null) {
      onNewCameraSelected(newDescription);
    } else {
      showInSnackBar('Asked camera not available');
    }
  }

  void handleScaleStart(ScaleStartDetails details) {
    baseScale.value = currentScale.value;
  }

  Future<void> handleScaleUpdate(ScaleUpdateDetails details) async {
    final CameraController cameraController = controllers;

    // When there are not exactly two fingers on screen don't scale
    if (cameraController == null || pointers.value != 2) {
      return;
    }

    currentScale.value = (baseScale.value * details.scale).clamp(minAvailableZoom.value, maxAvailableZoom.value);

    await cameraController.setZoomLevel(currentScale.value);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final CameraController cameraController = controllers;

    if (cameraController == null) {
      return;
    }

    final Offset offset = Offset(
      details.localPosition.dx / constraints.maxWidth,
      details.localPosition.dy / constraints.maxHeight,
    );
    cameraController.setExposurePoint(offset);
    cameraController.setFocusPoint(offset);
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = controllers;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return null;
    }

    if (cameraController.value.isTakingPicture) {
      // A capture is already pending, do nothing.
      return null;
    }

    try {
      final XFile file = await cameraController.takePicture();
      await Get.find<AudioController>().audioPlayer.play(AssetSource(Assets.cameraShutter));
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> saveThumbnailImage() async {
    // Request permissions
    var status = await Permission.photos.request();
    if (status.isGranted) {
      thumbnailDataPath.value = '/data/user/0/com.example.glive/cache/glive_thumbnail${fileCounter.value}.jpg';
      final File imageFile = File(thumbnailDataPath.value);

      // Verify if the file exists
      if (!imageFile.existsSync()) {
        log('Image file does not exist at ${thumbnailDataPath.value}');
        return;
      }

      final Directory? extDir = await getExternalStorageDirectory();
      if (extDir == null) {
        log('Failed to get external storage directory');
        return;
      }
      final String extPath = extDir.path;
      final String savedPath = '$extPath/glive_thumbnail${fileCounter.value}.jpg';

      await imageFile.copy(savedPath);

      if (Get.context!.mounted) {
        thumbnailDataPath.value = savedPath;
      }

      log('Image saved to $savedPath');
      log('Image saved to 2 ${thumbnailDataPath.value}');
    } else {
      log('Permission denied.');
    }
  }

  Future<void> generateThumbnailData() async {
    String command = "-i ${videoPath.value} -ss 00:00:01.000 -vframes 1 -q:v 2 ${thumbnailDataPath.value}";

    await FFmpegKit.executeAsync(command, (Session session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        log("Thumbnail generated successfully.");
      } else if (ReturnCode.isCancel(returnCode)) {
        log("Thumbnail generation canceled.");
      } else {
        log("Thumbnail generation failed.");
      }
    });
  }

  void showInSnackBar(String message) {
    showToast(message,
        textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
        position: ToastPosition.bottom);
  }

  void _showCameraException(CameraException e) {
    _logError(e.code, e.description);
    showToast('Error: ${e.code}\n${e.description}.',
        textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
        position: ToastPosition.bottom);
  }

  void _logError(String code, String? message) {
    // ignore: avoid_print
    print('Error: $code${message == null ? '' : '\nError Message: $message'}');
  }

  Future<void> resetCamera() async {
    final CameraController cameraController = controllers;
    timer?.cancel();
    videoFile = null;
    imageFile = null;
    // thumbnailFile.value = null;
    enableAudio.value = true;
    isRecording.value = false;
    isRecorded.value = false;
    isFlashOn.value = false;
    isFrontCamera.value = false;
    isInitializedCamera.value = false;
    minAvailableExposureOffset.value = 0.0;
    maxAvailableExposureOffset.value = 0.0;
    currentExposureOffset.value = 0.0;
    pointers.value = 0;
    cameraIndex.value = 0;
    recordDuration.value = 30;
    progressDuration.value = 0.0;
    elapsed.value = 0;
    minAvailableZoom.value = 1.0;
    maxAvailableZoom.value = 1.0;
    currentScale.value = 1.0;
    baseScale.value = 1.0;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    initializeCamera(cameraController.description);
  }

  void disposeCamera() {
    isInitializedCamera.value = false;
    controllers.dispose();

    log("CAMERA CONTROLLER IS DISPOSE ");
    update();
  }

  void reinitializeCamera() async {
    await initializeCamera(cameras.first);
    log("REINIT CAMERA CONTROLLER ");
  }

  @override
  void onClose() {
    // TODO: implement onClose
    log("Close CamerasController ");
    timer?.cancel();
    disposeCamera();
    flashModeControlRowAnimationController.dispose();
    exposureModeControlRowAnimationController.dispose();
    super.onClose();
  }
}

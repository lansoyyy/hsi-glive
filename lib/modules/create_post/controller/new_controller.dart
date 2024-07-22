// ignore_for_file: unnecessary_null_comparison, depend_on_referenced_packages, unused_local_variable, unrelated_type_equality_checks

import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:cached_video_player_plus/cached_video_player_plus.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/controllers/audios_controller.dart';
import 'package:glive/controllers/cameras_controller.dart';
import 'package:glive/modules/video/controller/video_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:oktoast/oktoast.dart';
import 'package:glive/main.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
// import 'package:video_compress/video_compress.dart';

class NewPostController extends GetxController with GetTickerProviderStateMixin {
  final AudioController audiosController = Get.put(AudioController());
  final CamerasController camerasController = Get.put(CamerasController());
  final VideoController videoController = Get.put(VideoController());

  RxInt selectedPostPageIndex = 0.obs;
  RxBool enableAudio = true.obs;
  Timer? timer;
  final postPageController = PageController(initialPage: 0).obs;
  RxBool isRecording = false.obs;
  RxBool isRecorded = false.obs;
  RxBool isFlashOn = false.obs;
  RxBool isFrontCamera = false.obs;
  RxBool isInitializedCamera = false.obs;
  late CameraController controller;

  XFile? imageFile;
  XFile? videoFile;
  // Rx<File?> thumbnailFile = Rx<File?>(null);
  CachedVideoPlayerPlusController? cachedVideoPlayerPlusController;
  VoidCallback? videoPlayerListener;
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
  RxBool isVIdeoPlaying = false.obs;

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
  RxString thumbnailFilePath = "".obs;

  final ImagePicker imagePicker = ImagePicker();
  List<XFile>? pickedImagesList;
  RxList<Uint8List> fileImagesList = <Uint8List>[].obs;
  AssetPathEntity? currentAlbum;
  RxList<AssetEntity> storageImagesList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> storageAlbums = <AssetPathEntity>[].obs;
  RxList<AssetEntity> selectedImageAssets = <AssetEntity>[].obs;
  RxList<File> selectedImageToFile = <File>[].obs;
  List<AssetEntity> imagesInAlbum = [];
  RxString selectedAlbumName = "".obs;
  RxBool isMediaLoading = false.obs;
  RxBool isMediaAlbumLoading = false.obs;

  RxInt currentMediaPage = 0.obs;
  RxInt mediaPerPage = 30.obs;
  RxBool isSelectedAsset = false.obs;
  RxBool isMultipleSelected = false.obs;

  RxBool isFullScreen = false.obs;
  RxBool isImagesScrolled = false.obs;
  Uint8List? initialImageData;
  RxInt addedImageCount = 0.obs;
  RxDouble container1HeightPercentage = 0.45.obs;
  RxDouble container2HeightPercentage = 0.45.obs;
  RxBool isDragging = false.obs;
  RxList<int> countList = <int>[].obs;
  RxInt imagePagesIndex = 0.obs;
  RxBool isImageEnlarge = false.obs;
  var firstPhoto = Rx<AssetEntity?>(null);
  RxString videoPath = "".obs;
  RxInt videoTapCount = 0.obs;
  @override
  void onInit() async {
    // TODO: implement onInit

    super.onInit();
    await checkAndRequestPermission();
    await loadImagesFromStorage();
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

  Future<void> checkAndRequestPermission() async {
    cameraPermissionStatus = await Permission.camera.status;
    microphonePermissionStatus = await Permission.microphone.status;
    log("cameraPermissionStatus $cameraPermissionStatus");
    log("microphonePermissionStatus $microphonePermissionStatus");
    if (cameraPermissionStatus!.isDenied && microphonePermissionStatus!.isDenied) {
      isCameraGranted.value = false;
      isMicrophoneGranted.value = false;
      return;
    } else if (cameraPermissionStatus!.isPermanentlyDenied && microphonePermissionStatus!.isPermanentlyDenied) {
      await openAppSettings();
    } else if (cameraPermissionStatus!.isGranted && microphonePermissionStatus!.isGranted) {
      isCameraGranted.value = true;
      isMicrophoneGranted.value = true;
      await initializeCamera(cameras.first);
    }
    storagePermissionStatus = await Permission.storage.status;
    log("storagePermissionStatus $storagePermissionStatus");
    if (storagePermissionStatus!.isDenied) {
      isStorageGranted.value = false;
      return;
    } else if (storagePermissionStatus!.isPermanentlyDenied) {
      await openAppSettings();
    } else if (storagePermissionStatus!.isGranted) {
      isStorageGranted.value = true;
    }
  }

  Future<void> onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      isFrontCamera.value = true;
      log("camere dle null");
      // return controller.setDescription(cameraDescription);
      return controller.setDescription(cameraDescription);
    } else {
      log("camere  null");
      isFrontCamera.value = false;
      return initializeCamera(cameraDescription);
    }
  }

  Future<void> initializeCamera(CameraDescription description) async {
    try {
      controller = CameraController(
        description,
        ResolutionPreset.high,
        enableAudio: enableAudio.value,
        imageFormatGroup: ImageFormatGroup.jpeg,
      );
      log("WEEE");
      log("WEEE INDEX ${cameraIndex.value}");
      controller.addListener(() {
        if (controller.value.hasError) {
          if (Get.context!.mounted) {
            update();
          }
          showInSnackBar('Camera error ${controller.value.errorDescription}');
        }
      });
      await controller.initialize().then((value) => isInitializedCamera.value = true);
      await Future.wait(<Future<Object?>>[
        // The exposure mode is currently not supported on the web.
        ...!kIsWeb
            ? <Future<Object?>>[
                controller.getMinExposureOffset().then((double value) => minAvailableExposureOffset.value = value),
                controller.getMaxExposureOffset().then((double value) => maxAvailableExposureOffset.value = value)
              ]
            : <Future<Object?>>[],
        controller.getMaxZoomLevel().then((double value) => maxAvailableZoom.value = value),
        controller.getMinZoomLevel().then((double value) => minAvailableZoom.value = value),
      ]);
    } on CameraException catch (e) {
      switch (e.code) {
        case 'CameraAccessDenied':
          showInSnackBar('You have denied camera access.');
        case 'CameraAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable camera access.');
        case 'CameraAccessRestricted':
          // iOS only
          showInSnackBar('Camera access is restricted.');
        case 'AudioAccessDenied':
          showInSnackBar('You have denied audio access.');
        case 'AudioAccessDeniedWithoutPrompt':
          // iOS only
          showInSnackBar('Please go to Settings app to enable audio access.');
        case 'AudioAccessRestricted':
          // iOS only
          showInSnackBar('Audio access is restricted.');
        default:
          _showCameraException(e);
          break;
      }
    }
    if (Get.context!.mounted) {
      update();
    }
  }

  void onTakePictureButtonPressed() {
    takePicture().then((XFile? file) {
      if (Get.context!.mounted) {
        imageFile = file;
        cachedVideoPlayerPlusController?.dispose();
        cachedVideoPlayerPlusController = null;
        isFileEmpty.value = false;
        isImageFile.value = true;
        update();
        if (file != null) {
          showInSnackBar('Picture saved to ${file.path}');
        }
      }
    });
  }

  void onTabSelected(int index) {
    selectedPostPageIndex.value = index;
    postPageController.value.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    if (index == 0) {
      reinitializeCamera();
      selectedPostPageIndex.value = index;
    } else {
      disposeCamera();
    }
  }

  Future<void> startVideoRecording(int duration) async {
    final CameraController cameraController = controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      showInSnackBar('Error: select a camera first.');
      return;
    }
    if (cameraController.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return;
    }
    try {
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
    final CameraController cameraController = controller;
    isRecording.value = false;
    isRecorded.value = true;
    isFileEmpty.value = false;
    isVideoFile.value = true;
    if (cameraController == null || !cameraController.value.isRecordingVideo) {
      return null;
    }
    try {
      return cameraController.stopVideoRecording();
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> pauseVideoRecording() async {
    final CameraController cameraController = controller;

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
    final CameraController cameraController = controller;

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

  void cancelRecording() {
    isRecorded.value = false;

    // Add your cancel function here
  }

  void confirmRecording() {
    isRecorded.value = false;

    // Add your confirm function here
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
    if (controller == null) {
      return;
    }

    try {
      await controller.setFlashMode(mode);
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
    final CameraController cameraController = controller;

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
    final CameraController cameraController = controller;

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
    final CameraController cameraController = controller;

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
        showInSnackBar('Video recorded to ${file.path.split('/').last}');
        videoFile = file;
        videoPath.value = videoFile!.path;
        update();
        startVideoPlayer();
      }
    });
  }

  Future<void> setFocusMode(FocusMode mode) async {
    final CameraController cameraController = controller;

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
    final CameraController cameraController = controller;

    // When there are not exactly two fingers on screen don't scale
    if (cameraController == null || pointers.value != 2) {
      return;
    }

    currentScale.value = (baseScale.value * details.scale).clamp(minAvailableZoom.value, maxAvailableZoom.value);

    await cameraController.setZoomLevel(currentScale.value);
  }

  void onViewFinderTap(TapDownDetails details, BoxConstraints constraints) {
    final CameraController cameraController = controller;

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

  Future<void> startVideoPlayer() async {
    if (videoFile == null) {
      return;
    }

    final CachedVideoPlayerPlusController vController = CachedVideoPlayerPlusController.file(File(videoFile!.path));

    videoPlayerListener = () {
      if (cachedVideoPlayerPlusController != null) {
        // Refreshing the state to update video player with the correct ratio.
        if (Get.context!.mounted) {
          update();
        }
        cachedVideoPlayerPlusController!.removeListener(videoPlayerListener!);
      }
    };
    vController.addListener(videoPlayerListener!);
    // await vController.setLooping(true);
    await vController.initialize();
    await cachedVideoPlayerPlusController?.dispose();
    if (Get.context!.mounted) {
      imageFile = null;
      cachedVideoPlayerPlusController = vController;
      update();
    }
    // await vController.play();
    // if (videoFile != null) {
    //   thumbnailFile.value = await VideoCompress.getFileThumbnail(videoFile!.path, quality: 50, position: -1);
    //   log("NEW FILE ${thumbnailFile.value!.path}");
    // }
  }

  Future<XFile?> takePicture() async {
    final CameraController cameraController = controller;
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
      return file;
    } on CameraException catch (e) {
      _showCameraException(e);
      return null;
    }
  }

  Future<void> openImagePicker() async {
    try {
      // final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

      final List<XFile> pickedImages = await imagePicker.pickMultiImage();

      // pickedImage = pickedFile;
      pickedImagesList = pickedImages;
      update();
    } catch (e) {
      log('Error picking image: $e');
    }
  }

  Future<void> loadImagesFromStorage() async {
    final PermissionState permissionState = await PhotoManager.requestPermissionExtend();
    if (permissionState.isAuth) {
      log("GRANTED");
      // Granted
      // You can to get assets here.
      isMediaAlbumLoading(true);
      if (GetPlatform.isAndroid) {
        List<AssetPathEntity> imageAlbums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(needTitle: true),
              orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
              videoOption: const FilterOption(needTitle: false)),
        );
        // Filter only image albums
        List<AssetPathEntity> imageAlbum = [];
        for (var album in imageAlbums) {
          final assetList = await album.getAssetListRange(start: 0, end: 1);
          if (assetList.isNotEmpty && assetList.first.type == AssetType.image) {
            imageAlbum.add(album);
          }
        }
        storageAlbums.assignAll(imageAlbum);
        currentAlbum = imageAlbum.firstWhere(
          (album) => album.name.toLowerCase() == 'Recents',
          orElse: () => imageAlbum.first,
        );
        selectedAlbumName.value = currentAlbum!.name;
        fetchImagesFromAlbumn(currentAlbum!);
      } else {
        List<AssetPathEntity> imageAlbums = await PhotoManager.getAssetPathList(
          type: RequestType.image,
          filterOption: FilterOptionGroup(
              imageOption: const FilterOption(needTitle: true),
              orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
              videoOption: const FilterOption(needTitle: false)),
        );
        // Filter only image albums
        List<AssetPathEntity> imageAlbum = [];
        for (var album in imageAlbums) {
          final assetList = await album.getAssetListRange(start: 0, end: 1);
          if (assetList.isNotEmpty && assetList.first.type == AssetType.image) {
            imageAlbum.add(album);
          }
        }
        storageAlbums.assignAll(imageAlbum);
        currentAlbum = imageAlbum.firstWhere(
          (album) => album.name == 'Recents',
          orElse: () => imageAlbum.first,
        );
        selectedAlbumName.value = currentAlbum!.name;
        fetchImagesFromAlbumn(currentAlbum!);
      }
      isMediaAlbumLoading(false);
      update();
    } else if (permissionState.hasAccess) {
      // Access will continue, but the amount visible depends on the user's selection.
      log("HAS ACCESS");
    } else {
      PhotoManager.openSetting();
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
    }
  }

  Future<void> fetchImagesFromAlbumn(AssetPathEntity currentAlbum) async {
    isMediaLoading(true);
    storageImagesList.clear();
    int count = await currentAlbum.assetCountAsync;
    final List<AssetEntity> photos = await currentAlbum.getAssetListPaged(page: currentMediaPage.value, size: count);
    storageImagesList.assignAll(photos);
    if (photos.isNotEmpty) {
      firstPhoto.value = photos.first;
    }
    log("ALBUM C ${selectedAlbumName.value} LIST ${storageImagesList.length}");
    isMediaLoading(false);
    currentMediaPage.value++;
    update();
  }

  // Future<int> getImagesCount(AssetPathEntity currentAlbum) async {
  //   int imagesCount = await currentAlbum.assetCountAsync;
  //   return imagesCount;
  // }
  Future<List<File>> uint8ListToFileList(List<Uint8List> uint8List, String filePrefix) async {
    Directory tempDir = await getTemporaryDirectory();

    List<File> fileList = [];

    for (int i = 0; i < uint8List.length; i++) {
      File file = File('${tempDir.path}/$filePrefix$i.jpg');
      await file.writeAsBytes(uint8List[i]);
      fileList.add(file);
    }

    return fileList;
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
    final CameraController cameraController = controller;
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

  // Future<void> useEntity(List<AssetEntity> entity) async {
  //   File? file;
  //   try {
  //     file = await entity.file;
  //     // await handleFile(file!);
  //   } finally {
  //     if (Platform.isIOS) {
  //       file?.deleteSync(); // Delete it once the process has done.
  //     }
  //   }
  // }

  //Disposing camera when not needed
  void disposeCamera() {
    isInitializedCamera.value = false;
    controller.dispose();

    log("CAMERA CONTROLLER IS DISPOSE ");
    update();
  }

  //Dispose camera controller and reinitiaze camera
  void reinitializeCamera() async {
    await initializeCamera(cameras.first);
    log("REINIT CAMERA CONTROLLER ");
  }

  void disposePhotoManager() {
    PhotoManager.clearFileCache();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    disposePhotoManager();
    timer?.cancel();
    disposeCamera();
    flashModeControlRowAnimationController.dispose();
    exposureModeControlRowAnimationController.dispose();
    super.onClose();
  }
}

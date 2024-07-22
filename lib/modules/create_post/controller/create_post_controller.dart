// ignore_for_file: unnecessary_null_comparison

import 'dart:developer';
import 'dart:io';
import 'dart:math' as math;

import 'package:camera/camera.dart';
import 'package:ffmpeg_kit_flutter/ffmpeg_kit.dart';
import 'package:ffmpeg_kit_flutter/return_code.dart';
import 'package:ffmpeg_kit_flutter/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:glive/constants/Assets.dart';
import 'package:glive/controllers/audios_controller.dart';
import 'package:glive/controllers/cameras_controller.dart';
import 'package:glive/controllers/photos_controller.dart';
import 'package:glive/controllers/videos_controller.dart';
import 'package:glive/main.dart';
import 'package:glive/models/app/AudioModel.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:http/http.dart' as http;

enum Selection { everyone, onlyMe }

class CreatePostController extends GetxController with WidgetsBindingObserver {
  final AudioController audio = Get.put(AudioController());
  final CamerasController camera = Get.put(CamerasController());
  final PhotosController photos = Get.put(PhotosController());
  final VideosController video = Get.put(VideosController());
  var gridViewScrollController = ScrollController().obs;
  var draggableScrollableController = DraggableScrollableController().obs;

  var titleController = TextEditingController().obs;
  var descController = TextEditingController().obs;
  var searchController = TextEditingController().obs;

  var privacyOption = Selection.everyone.obs;
  RxString privacyDesc = "Everyone can view".obs;
  RxBool isCameraSelected = false.obs;
  RxBool isCommentSwitchOn = false.obs;

  RxInt selectedPostPageIndex = 0.obs;
  final postPageController = PageController(initialPage: 0).obs;
  final modePageController = PageController(initialPage: 0).obs;

  RxList<AudioMood> soundCategories = <AudioMood>[].obs;
  RxList<AudioMood> soundCategoryList = <AudioMood>[].obs;

  RxList<AudioModel> audioDataModel = <AudioModel>[].obs;
  RxList<AudioModel> audioDataModel2 = <AudioModel>[].obs;
  RxList<HashtagData> hashtagDataList = <HashtagData>[].obs;
  RxList<HashtagData> hashtagDataMasterList = <HashtagData>[].obs;
  RxList<HashtagData> selectedHashtags = <HashtagData>[].obs;

  RxDouble xPosition = 0.0.obs;
  RxDouble yPosition = 0.0.obs;
  RxInt fileCounter = 1.obs;

  RxString selectedMoodTitle = "".obs;
  RxString selectedMoodDesc = "".obs;
  RxString selectedSoundTitle = "".obs;
  RxString selectedSoundDesc = "".obs;
  RxString selectedSoundAudio = "".obs;
  RxString audioDataPath = "".obs;
  RxString outputDataPath = "".obs;

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    WidgetsBinding.instance.addObserver(this);

    await camera.checkAndRequestPermission();
    camera.initAnimationControllers();
    gridViewScrollController.value.addListener(gridViewScrollListenter);
    if (!photos.isInitialized.value) {
      photos.checkAndRequestPermission();
    }

    initializeDataPaths();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController cameraController = camera.controllers;

    // App state changed before we got the chance to initialize.
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      camera.disposeCamera();
    } else if (state == AppLifecycleState.resumed) {
      if (selectedPostPageIndex.value == 0 || isCameraSelected.value) {
        camera.reinitializeCamera();
      }
    }
  }

  void onTabSelected(int index) {
    selectedPostPageIndex.value = index;
    postPageController.value.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onPageChanged(int index) {
    if (index == 0) {
      camera.reinitializeCamera();
      selectedPostPageIndex.value = index;
    } else {
      camera.disposeCamera();
      selectedPostPageIndex.value = index;
      // if (!photos.isInitialized.value) {
      //   photos.checkAndRequestPermission();
      // }
    }
  }

  void toggleSwitch(bool value) {
    isCommentSwitchOn.value = value;
  }

  void onSelectPrivacy(Selection value) {
    privacyOption.value = value;
    if (value == Selection.everyone) {
      privacyDesc.value = "Everyone can view";
    } else {
      privacyDesc.value = "Only me";
    }
  }

  void gridViewScrollListenter() {
    if (gridViewScrollController.value.position.userScrollDirection == ScrollDirection.reverse) {
      draggableScrollableController.value.animateTo(1.0, duration: const Duration(milliseconds: 100), curve: Curves.easeInOut);
    } else if (gridViewScrollController.value.position.userScrollDirection == ScrollDirection.forward) {
      if (gridViewScrollController.value.position.atEdge && gridViewScrollController.value.position.pixels == 0) {
        draggableScrollableController.value.animateTo(0.1, duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
      }
    }
  }

  void onDragDetailChanges(DraggableDetails dragDetails) {
    // Adjust for screen boundaries
    double newX = dragDetails.offset.dx;
    double newY = dragDetails.offset.dy;
    double screenWidth = Get.width;
    double screenHeight = Get.height;

    // Ensure the button stays within the screen
    if (newX < 0) newX = 0;
    if (newY < 0) newY = 0;
    if (newX + 60 > screenWidth) newX = screenWidth - 60;
    if (newY + 60 > screenHeight) newY = screenHeight - 60;

    xPosition.value = newX;
    yPosition.value = newY;
  }

  void onVideoTapped() {
    video.videoTapCount.value++;
    if (video.videoTapCount.value % 2 == 0) {
      video.cachedVideoPlayerPlusController!.pause();
      video.isVideoPlaying.value = false;
    } else {
      video.cachedVideoPlayerPlusController!.play();
      video.isVideoPlaying.value = true;
    }
  }

  void onloadAlbumPhotos(AssetPathEntity album) async {
    photos.selectedAlbumName.value = album.name;
    await photos.loadPhotosFromAlbum(album);
    Get.back();
  }

  Future<void> onCameraAudioPermissionRequest() async {
    camera.cameraPermissionStatus = await Permission.camera.request();
    if (camera.cameraPermissionStatus!.isGranted) {
      camera.isCameraGranted.value = true;
      camera.initializeCamera(cameras.first);
    }
    update();
  }

  Future<void> microphonePermissionRequest() async {
    camera.microphonePermissionStatus = await Permission.microphone.request();
    if (camera.cameraPermissionStatus!.isGranted) {
      camera.isMicrophoneGranted.value = true;
    } else {
      showInSnackBar("Microphone is deniad, cannot record a video");
    }
  }

  void onFlashModeTapped() {
    if (camera.controllers.value.description.lensDirection != CameraLensDirection.front) {
      if (camera.isFlashOn.value == false) {
        log("FLASH ON");
        camera.isFlashOn.value = true;
        camera.onSetFlashModeButtonPressed(FlashMode.torch);
      } else {
        log("FLASH OFF");
        camera.isFlashOn.value = false;
        camera.onSetFlashModeButtonPressed(FlashMode.off);
      }
    } else {
      camera.showInSnackBar('Torch is not supported');
    }
  }

  void onImageSelected(AssetEntity assets) {
    if (photos.isMultipleSelected.value) {
      if (photos.selectedImageAssets.contains(assets)) {
        photos.isSelectedAsset.value = false;
        photos.selectedImageAssets.remove(assets);
      } else {
        photos.selectedImageAssets.insert(0, assets);
        photos.isSelectedAsset.value = true;
      }
    } else {
      photos.selectedImageAssets.clear();
      photos.selectedImageAssets.add(assets);
    }
  }

  void onScrolledImages(ScrollDirection direction, UserScrollNotification notification) async {
    if (direction == ScrollDirection.forward) {
      photos.isImagesScrolled.value = true;
      if (!photos.isMediaLoading.value && notification.metrics.pixels == notification.metrics.maxScrollExtent) {
        await photos.loadPhotosFromAlbum(photos.currentAlbum!);
      }
    } else if (direction == ScrollDirection.reverse) {
      photos.isImagesScrolled.value = true;
    } else {
      if (!photos.isMediaLoading.value) {
        photos.isImagesScrolled.value = false;
      }
      log("direction");
    }
  }

  void onMode1ItemSelected(int index, AudioMood audioMood) {
    selectedMoodTitle.value = audioMood.title;
    selectedMoodDesc.value = audioMood.description;
    // Generate a random length for list2
    int randomLength = math.Random().nextInt(audioDataModel.length) + 1;
    audioDataModel2.value = audioDataModel.sublist(0, randomLength);

    modePageController.value.animateToPage(1, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void onMusicItemSelected(AudioModel audioModel) {
    selectedSoundTitle.value = audioModel.title;
    selectedSoundDesc.value = audioModel.description;
    selectedSoundAudio.value = audioModel.audio;

    log("Mood Title ${selectedMoodTitle.value}");
    log("Mood Icon ${selectedMoodDesc.value}");
    log("Sound Title ${selectedSoundTitle.value}");
    log("Sound Description ${selectedSoundDesc.value}");
    log("Sound Audio ${selectedSoundAudio.value}");

    Get.back();
  }

  void onModeBackPressed() {
    modePageController.value.animateToPage(0, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
    selectedMoodTitle.value = "";
    if (audio.isAudioPlaying.value) {
      audio.stopAudio();
    }
  }

  void initSoundCategories() {
    searchController.value.clear();
    soundCategories.clear();
    soundCategoryList.clear();
    soundCategoryList.value = [
      AudioMood(title: 'Happy', description: Assets.happy),
      AudioMood(title: 'Funny', description: Assets.funny),
      AudioMood(title: 'Playful', description: Assets.playfull),
      AudioMood(title: 'Sad', description: Assets.sad),
      AudioMood(title: 'Dramatic', description: Assets.dramatic),
      AudioMood(title: 'Angry', description: Assets.angry),
      AudioMood(title: 'Scary', description: Assets.scary),
      AudioMood(title: 'Powerful', description: Assets.powerful),
      AudioMood(title: 'Love', description: Assets.love),
      AudioMood(title: 'Groovy', description: Assets.grovvy),
    ];
    soundCategories.addAll(soundCategoryList);
    initAudioDataList();
  }

  void initAudioDataList() {
    audioDataModel.clear();
    audioDataModel.value = [
      AudioModel(
          title: "Master Of Puppets",
          description: "Metallica 8:40",
          icon: Assets.bts,
          audio: "https://ksmiguel.com/unleash/files/music.mp3",
          isPlaying: false),
      AudioModel(
          title: "And Justice For All",
          description: "Metallica 9:12",
          icon: Assets.bts,
          audio: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3",
          isPlaying: false),
      AudioModel(
          title: "Tornado Of Souls",
          description: "Megadeth 5:34",
          icon: Assets.bts,
          audio: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-2.mp3",
          isPlaying: false),
      AudioModel(
          title: "Sad But True",
          description: "Metallica 4:43",
          icon: Assets.bts,
          audio: "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3",
          isPlaying: false),
    ];
  }

  void initHashtagData() {
    searchController.value.clear();
    hashtagDataMasterList.value = [
      HashtagData(id: "1", title: '#happy'),
      HashtagData(id: "2", title: '#sad'),
      HashtagData(id: "3", title: '#sexylady'),
      HashtagData(id: "4", title: '#sharinglife'),
      HashtagData(id: "5", title: '#lifestyle'),
      HashtagData(id: "6", title: '#photography'),
      HashtagData(id: "7", title: '#love'),
      HashtagData(id: "8", title: '#art'),
      HashtagData(id: "9", title: '#fashion'),
      HashtagData(id: "10", title: '#music'),
      HashtagData(id: "11", title: '#fashion'),
      HashtagData(id: "12", title: '#photooftheday'),
      HashtagData(id: "13", title: '#reels'),
      HashtagData(id: "14", title: '#travle'),
      HashtagData(id: "15", title: '#model'),
      HashtagData(id: "16", title: '#explore'),
      HashtagData(id: "17", title: '#wedding'),
      HashtagData(id: "18", title: '#explorepage'),
      HashtagData(id: "19", title: '#makeup'),
      HashtagData(id: "20", title: '#summer'),
      HashtagData(id: "21", title: '#beauty'),
      HashtagData(id: "22", title: '#nature'),
      HashtagData(id: "23", title: '#artist'),
      HashtagData(id: "24", title: '#style'),
    ];
    hashtagDataList.addAll(hashtagDataMasterList);
  }

  void onSelectedHastag(int index) {
    if (selectedHashtags.contains(hashtagDataList[index])) {
      log("REMOVE");
      selectedHashtags.remove(hashtagDataList[index]);
      update();
    } else {
      log("ADD");
      selectedHashtags.add(hashtagDataList[index]);
      update();
    }
  }

  void filterMoodMusic(String query) {
    soundCategories.value =
        soundCategoryList.where((moodcategory) => moodcategory.title.toLowerCase().contains(query.toLowerCase()) == true).toList();
  }

  void filterHashtagData(String query) {
    hashtagDataList.value = hashtagDataMasterList.where((hashtag) => hashtag.title.toLowerCase().contains(query.toLowerCase()) == true).toList();
  }

  //Delete resources from video record or camera capture
  Future<void> deleteCachedFile(String filePath) async {
    try {
      final file = File(filePath);
      if (await file.exists()) {
        if (Platform.isIOS) {
          log('File deleted ios: $filePath');
          file.deleteSync();
        } else {
          log('File deleted android : $filePath');
          await file.delete();
        }
      } else {
        log('File does not exist: $filePath');
      }
    } catch (e) {
      log('Error deleting file: $e');
    }
  }

  //Delete assets entity selected after an api call
  Future<void> deleteEntityFile(List<AssetEntity> entity) async {
    File? file;
    try {
      file = await entity.first.file;
      if (Platform.isIOS) {
        log('File deleted ios Entity : ${file!.path}');
        file.deleteSync();
      } else {
        log('File deleted android Entity : ${file!.path}');
        await file.delete();
      }
    } catch (e) {
      log('Error deleting file Entity : $e');
    }
  }

  void initializeDataPaths() async {
    final directory = await getApplicationDocumentsDirectory();
    audioDataPath.value = '${directory.path}/glive_mudic${fileCounter.value}.mp3';
    outputDataPath.value = '${directory.path}/glive_video${fileCounter.value}.mp4';
  }

  Future<void> downloadAudioData() async {
    final response = await http.get(Uri.parse(selectedSoundAudio.value));
    if (response.statusCode == 200) {
      final file = File(audioDataPath.value);
      await file.writeAsBytes(response.bodyBytes);
    } else {
      throw Exception('Failed to download audio');
    }
  }

  void processVideoData() async {
    await downloadAudioData();

    String command = "-i ${camera.videoPath.value} -i ${audioDataPath.value} -c:v copy -map 0:v:0 -map 1:a:0 -shortest -y ${outputDataPath.value}";

    FFmpegKit.executeAsync(command, (Session session) async {
      final returnCode = await session.getReturnCode();

      if (ReturnCode.isSuccess(returnCode)) {
        log("Video processed successfully.");
        fileCounter.value++;
        initializeDataPaths(); // Update paths for the next iteration
        await video.reinitiaalizeVideoPlayer(outputDataPath.value);
      } else if (ReturnCode.isCancel(returnCode)) {
        log("Video processing canceled.");
      } else {
        log("Video processing failed.");
      }
    });
  }

  void resetNoodSoundVars() {
    if (audio.isAudioPlaying.value) {
      audio.stopAudio();
    }
    selectedMoodTitle.value = "";
    selectedMoodDesc.value = "";
    selectedSoundTitle.value = "";
    selectedSoundDesc.value = "";
    selectedSoundAudio.value = "";
    titleController.value.clear();
    descController.value.clear();
    searchController.value.clear();
    log("Clear Fields");
  }

  void showInSnackBar(String message) {
    showToast(message,
        textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
        position: ToastPosition.bottom);
  }

  @override
  void onClose() {
    gridViewScrollController.value.dispose();
    isCameraSelected.value = false;
    WidgetsBinding.instance.removeObserver(this);

    soundCategories.clear();
    audioDataModel.clear();
    audioDataModel2.clear();
    // TODO: implement onClose
    Get.delete<AudioController>();
    Get.delete<CamerasController>();
    Get.delete<PhotosController>();
    Get.delete<VideosController>();
    super.onClose();
  }
}

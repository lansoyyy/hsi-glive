// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
// import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotosController extends GetxController {
  static PhotosController get to => Get.find();
  AssetPathEntity? currentAlbum;
  AssetPathEntity? curvideoAlbum;
  // PermissionStatus? photosPermissionStatus;
  PermissionState? permissionState;
  RxBool isPhotoseGranted = false.obs;
  AssetEntity? selectedVideo;
  //PHOTOS
  RxList<AssetEntity> storageImagesList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> photoAlbums = <AssetPathEntity>[].obs;
  RxList<AssetEntity> selectedImageAssets = <AssetEntity>[].obs;
  //VIDEOS
  RxList<AssetEntity> storageVideoList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> videoAlbums = <AssetPathEntity>[].obs;
  RxList<AssetEntity> selectedVideoAssets = <AssetEntity>[].obs;
  RxString selectedAlbumName = "".obs;
  RxBool isMediaLoading = false.obs;
  RxBool isMediaAlbumLoading = false.obs;
  RxInt currentMediaPage = 0.obs;
  RxBool isMultipleSelected = false.obs;
  RxBool isImagesScrolled = false.obs;
  RxBool isDragging = false.obs;
  RxInt imagePagesIndex = 0.obs;
  RxBool isImageEnlarge = false.obs;
  RxBool isSelectedAsset = false.obs;
  var firstMedia = Rx<AssetEntity?>(null);
  var firstVideo = Rx<AssetEntity?>(null);
  var isInitialized = false.obs;
  RxString thumbnailImage = ''.obs;

  Future<void> checkPhotoManagerPermission() async {
    permissionState = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
          androidPermission: AndroidPermission(
        type: RequestType.all,
        mediaLocation: true,
      )),
    );
    final hasPhotoPermission = permissionState!.isAuth;
    log("PERMISSION ISAUTH hasPhotoPermission $hasPhotoPermission");

    if (permissionState!.isAuth || permissionState!.hasAccess) {
      // Granted, You can to get assets here.
      isPhotoseGranted.value = true;
      // Access will continue, but the amount visible depends on the user's selection.
      loadAllAlbumAndMedia();
    } else {
      isPhotoseGranted.value = false;
      PhotoManager.presentLimited();
    }
  }

  void loadAllAlbumAndMedia() async {
    if (GetPlatform.isAndroid) {
      await loadAlbumsAndVideos();
      await loadAlbumsAndPhotos();
      // await loadAlbumPhotoVideosAssets();
    } else {
      await loadAlbumsAndVideos();
      await loadAlbumsAndPhotos();
      // await loadAlbumPhotoVideosAssets();
    }
  }

  //------------START PHOTOS----------------//
  Future<void> loadAlbumsAndPhotos() async {
    try {
      isMediaAlbumLoading(true);
      List<AssetPathEntity> albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        filterOption: FilterOptionGroup(
          orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
          containsPathModified: true,
        ),
      );
      // Filter only image albums
      List<AssetPathEntity> photoAlbum = [];
      for (var media in albums) {
        final assetList = await media.getAssetListRange(start: 0, end: 1);
        if (assetList.isNotEmpty && assetList.first.type == AssetType.image) {
          photoAlbum.add(media);
        }
      }

      photoAlbums.assignAll(photoAlbum);
      currentAlbum = photoAlbum.firstWhere((album) => album.name == 'Recent', orElse: () => photoAlbum.first);
      selectedAlbumName.value = currentAlbum!.name;
      await loadPhotosFromAlbum(currentAlbum!);
      // await loadVideosFromAlbum(currentAlbum!);

      isInitialized.value = true;
      isMediaAlbumLoading(false);
    } catch (e) {
      log("Error loadAlbumsAndPhotos ${e.toString()}");
    }
  }

  Future<void> loadPhotosFromAlbum(AssetPathEntity currentAlbum) async {
    try {
      isMediaLoading(true);
      storageImagesList.clear();
      int count = await currentAlbum.assetCountAsync;
      log("LIST SIZE C $count");
      final List<AssetEntity> photos = await currentAlbum.getAssetListPaged(page: 0, size: count);
      storageImagesList.assignAll(photos);
      if (photos.isNotEmpty) {
        firstMedia.value = photos.first;
      }
      log("ALBUM C ${selectedAlbumName.value} LIST ${storageImagesList.length}");
      isMediaLoading(false);
      currentMediaPage.value++;
      update();
    } catch (e) {
      log("Error loadPhotosFromAlbum ${e.toString()}");
    }
  }

  //------------END PHOTOS----------------//

  //------------START VIDEOS----------------//
  Future<void> loadAlbumsAndVideos() async {
    try {
      isMediaAlbumLoading(true);
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList(type: RequestType.video);
      log("Error LIST SIZE V a ${list.length}");
      if (list.isNotEmpty) {
        List<AssetEntity> videos = await list[0].getAssetListPaged(page: 0, size: 1);
        if (videos.isNotEmpty) {
          firstVideo.value = videos[0];
        }
      }
      int count = await list[0].assetCountAsync;
      log("LIST SIZE Vs $count");
      final List<AssetEntity> videos = await list[0].getAssetListPaged(page: currentMediaPage.value, size: count);
      storageVideoList.assignAll(videos);

      log("ALBUM V ${list[0].name} LIST ${storageVideoList.length}");
      isInitialized.value = true;
      isMediaAlbumLoading(false);
    } catch (e) {
      log("Error loadAlbumsAndVideos ${e.toString()}");
    }
  }

  void showInSnackBar(String message) {
    showToast(message,
        textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
        position: ToastPosition.bottom);
  }

  Future<void> saveThumbnailImage(String thumbnail, int counter) async {
    // Request permissions
    var status = await Permission.photos.request();
    if (status.isGranted) {
      String existingImagePath = '/data/user/0/com.example.glive/cache/glive_thumbnail$counter.jpg';
      final File imageFile = File(existingImagePath);

      // Verify if the file exists
      if (!imageFile.existsSync()) {
        log('Image file does not exist at $existingImagePath');
        return;
      }

      final Directory? extDir = await getExternalStorageDirectory();
      if (extDir == null) {
        log('Failed to get external storage directory');
        return;
      }
      final String extPath = extDir.path;
      final String savedPath = '$extPath/glive_thumbnail$counter.jpg';

      await imageFile.copy(savedPath);

      if (Get.context!.mounted) {
        thumbnailImage.value = savedPath;
      }

      log('Image saved to $savedPath');
    } else {
      log('Permission denied.');
    }
  }

  // void resetPhotoController() {
  //   storageImagesList.clear();
  //   photoAlbums.clear();
  //   selectedImageAssets.clear();
  //   storageVideoList.clear();
  //   videoAlbums.clear();
  //   selectedIVideoAssets.clear();
  //   selectedAlbumName.value = "";
  //   isMediaLoading.value = false;
  //   isMediaAlbumLoading.value = false;
  //   currentMediaPage.value = 0;
  //   isMultipleSelected.value = false;
  //   isImagesScrolled.value = false;
  //   isDragging.value = false;
  //   imagePagesIndex.value = 0;
  //   isImageEnlarge.value = false;
  //   isSelectedAsset.value = false;
  // }

  @override
  void onInit() async {
    // TODO: implement onInit
    log("Init PhotosController ");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    log("Close PhotosController ");
    super.onClose();
  }
}

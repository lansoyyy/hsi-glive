import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:oktoast/oktoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:photo_manager/photo_manager.dart';

class PhotosController extends GetxController {
  static PhotosController get to => Get.find();
  AssetPathEntity? currentAlbum;
  AssetPathEntity? curvideoAlbum;
  PermissionStatus? photosPermissionStatus;
  RxBool isPhotoseGranted = false.obs;

  //PHOTOS
  RxList<AssetEntity> storageImagesList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> photoAlbums = <AssetPathEntity>[].obs;
  RxList<AssetEntity> selectedImageAssets = <AssetEntity>[].obs;
  //VIDEOS
  RxList<AssetEntity> storageVideoList = <AssetEntity>[].obs;
  RxList<AssetPathEntity> videoAlbums = <AssetPathEntity>[].obs;
  RxList<AssetEntity> selectedIVideoAssets = <AssetEntity>[].obs;
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
  // var recentPhotos = <AssetEntity>[].obs;
  // var recentVideos = <AssetEntity>[].obs;
  // var allPhotos = <AssetEntity>[].obs;
  // var allVideos = <AssetEntity>[].obs;
  // var albums = <AssetPathEntity>[].obs;
  // var selectedAssets = <AssetEntity>[].obs;
  // var isMultiSelect = false.obs;
  // var currentAlbum = "Recents".obs;
  // var firstPhoto = Rx<AssetEntity?>(null);
  // var firstVideo = Rx<AssetEntity?>(null);

  Future<void> checkAndRequestPermission() async {
    photosPermissionStatus = await Permission.photos.status;
    log("photosPermissionStatus $photosPermissionStatus");
    if (photosPermissionStatus!.isDenied) {
      isPhotoseGranted.value = false;
    } else if (photosPermissionStatus!.isPermanentlyDenied) {
      isPhotoseGranted.value = false;
    } else if (photosPermissionStatus!.isGranted) {
      isPhotoseGranted.value = true;
      await checkPhotoManagerPermission();
    }
  }

  Future<void> oPhotosPermissionRequest() async {
    photosPermissionStatus = await Permission.camera.request();
    if (photosPermissionStatus!.isGranted) {
      isPhotoseGranted.value = true;
      await checkPhotoManagerPermission();
    }
    update();
  }

  Future<void> checkPhotoManagerPermission() async {
    final PermissionState permissionState = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
          androidPermission: AndroidPermission(
        type: RequestType.image,
        mediaLocation: true,
      )),
    );
    final hasPhotoPermission = permissionState.isAuth;
    log("PERMISSION ISAUTH hasPhotoPermission $hasPhotoPermission");

    if (permissionState.isAuth) {
      // Granted, You can to get assets here.
      loadAllAlbumAndMedia();
    } else if (permissionState.hasAccess) {
      // Access will continue, but the amount visible depends on the user's selection.
      loadAllAlbumAndMedia();
    } else {
      PhotoManager.presentLimited();

      // PhotoManager.openSetting();
      // Limited(iOS) or Rejected, use `==` for more precise judgements.
      // You can call `PhotoManager.openSetting()` to open settings for further steps.
    }
  }

  void loadAllAlbumAndMedia() async {
    if (GetPlatform.isAndroid) {
      await loadAlbumsAndVideos();
      await loadAlbumsAndPhotos();
    } else {
      await loadAlbumsAndVideos();
      await loadAlbumsAndPhotos();
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
      for (var photo in albums) {
        final assetList = await photo.getAssetListRange(start: 0, end: 1);
        if (assetList.isNotEmpty && assetList.first.type == AssetType.image) {
          photoAlbum.add(photo);
        }
      }
      photoAlbums.assignAll(photoAlbum);
      currentAlbum = photoAlbum.firstWhere((album) => album.name == 'Recents', orElse: () => photoAlbum.first);
      selectedAlbumName.value = currentAlbum!.name;
      await loadPhotosFromAlbum(currentAlbum!);
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
    } catch (e) {
      log("Error loadPhotosFromAlbum ${e.toString()}");
    }
  }

  //------------END PHOTOS----------------//

  //------------START VIDEOS----------------//
  Future<void> loadAlbumsAndVideos() async {
    try {
      isMediaAlbumLoading(true);
      List<AssetPathEntity> album = await PhotoManager.getAssetPathList(
        type: RequestType.video,
        filterOption: FilterOptionGroup(
          orders: [const OrderOption(type: OrderOptionType.createDate, asc: false)],
          containsPathModified: true,
        ),
      );
      log("Error LIST SIZE V a ${album.length}");
      log("Error LIST SIZE V a ${album.first.type.containsVideo()}");

      // Filter only image albums
      List<AssetPathEntity> videoAlbum = [];
      for (var video in album) {
        final assetList = await video.getAssetListRange(start: 0, end: 1);
        if (assetList.isNotEmpty && assetList.first.type == AssetType.video) {
          videoAlbum.add(video);
        }
      }
      videoAlbums.assignAll(videoAlbum);
      log("Error LIST SIZE V s ${videoAlbums.length}");
      curvideoAlbum = videoAlbum.firstWhere((album) => album.name == 'Recents', orElse: () => videoAlbum.first);
      log("Error LIST SIZE V d ${curvideoAlbum!.name}");
      log("Error LIST SIZE V h ${videoAlbums.first}");

      selectedAlbumName.value = curvideoAlbum!.name;
      await loadVideosFromAlbum(videoAlbums.first);
      isInitialized.value = true;
      isMediaAlbumLoading(false);
    } catch (e) {
      log("Error loadAlbumsAndVideos ${e.toString()}");
    }
  }

  Future<void> loadVideosFromAlbum(AssetPathEntity currentAlbum) async {
    try {
      isMediaLoading(true);
      storageVideoList.clear();
      int count = await currentAlbum.assetCountAsync;
      log("LIST SIZE V $count");
      final List<AssetEntity> videos = await currentAlbum.getAssetListPaged(page: currentMediaPage.value, size: count);
      storageVideoList.assignAll(videos);
      if (videos.isNotEmpty) {
        firstMedia.value = videos.first;
      }
      log("ALBUM V ${selectedAlbumName.value} LIST ${storageVideoList.length}");
      isMediaLoading(false);
      currentMediaPage.value++;
    } catch (e) {
      log("Error loadVideosFromAlbum ${e.toString()}");
    }
  }
  //------------END VIDEOS----------------//

  void showInSnackBar(String message) {
    showToast(message,
        textPadding: EdgeInsets.symmetric(horizontal: 16.sp, vertical: 10.sp),
        textStyle: TextStyle(color: Colors.white, fontSize: 16.sp, fontWeight: FontWeight.w200),
        position: ToastPosition.bottom);
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

  // Future<void> loadAssets() async {
  //   await PhotoManager.requestPermissionExtend();
  //   final List<AssetPathEntity> photoPaths = await PhotoManager.getAssetPathList(
  //     type: RequestType.image,
  //     filterOption: FilterOptionGroup(
  //       orders: [OrderOption(type: OrderOptionType.createDate, asc: false)],
  //       containsPathModified: true,
  //     ),
  //   );
  //   final List<AssetPathEntity> videoPaths = await PhotoManager.getAssetPathList(
  //     type: RequestType.video,
  //     filterOption: FilterOptionGroup(
  //       orders: [OrderOption(type: OrderOptionType.createDate, asc: false)],
  //       containsPathModified: true,
  //     ),
  //   );

  //   // Load all photos and videos
  //   for (var path in photoPaths) {
  //     final List<AssetEntity> assets = await path.getAssetListPaged(page: 0, size: 100);
  //     allPhotos.addAll(assets);
  //   }
  //   for (var path in videoPaths) {
  //     final List<AssetEntity> assets = await path.getAssetListPaged(page: 0, size: 100);
  //     allVideos.addAll(assets);
  //   }

  //   // Load recent photos and videos
  //   if (photoPaths.isNotEmpty) {
  //     final List<AssetEntity> recentPhotoAssets = await photoPaths.first.getAssetListPaged(page: 0, size: 100);
  //     recentPhotos.assignAll(recentPhotoAssets);
  //     if (recentPhotoAssets.isNotEmpty) {
  //       firstPhoto.value = recentPhotoAssets.first;
  //     }
  //   }

  //   if (videoPaths.isNotEmpty) {
  //     final List<AssetEntity> recentVideoAssets = await videoPaths.first.getAssetListPaged(page: 0, size: 100);
  //     recentVideos.assignAll(recentVideoAssets);
  //     if (recentVideoAssets.isNotEmpty) {
  //       firstVideo.value = recentVideoAssets.first;
  //     }
  //   }

  //   // Combine photo and video albums
  //   albums.assignAll([...photoPaths, ...videoPaths]);
  // }

  // Future<void> loadAssetsFromAlbum(AssetPathEntity album) async {
  //   final List<AssetEntity> assets = await album.getAssetListPaged(page: 0, size: 100);
  //   if (album.type == RequestType.image) {
  //     recentPhotos.assignAll(assets);
  //   } else if (album.type == RequestType.video) {
  //     recentVideos.assignAll(assets);
  //   }
  //   currentAlbum.value = album.name;
  //   if (assets.isNotEmpty) {
  //     if (album.type == RequestType.image) {
  //       firstPhoto.value = assets.first;
  //     } else if (album.type == RequestType.video) {
  //       firstVideo.value = assets.first;
  //     }
  //   }
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

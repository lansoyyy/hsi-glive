import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionService extends GetxService {
  static PermissionStatus? cameraPermissionStatus;
  static PermissionStatus? microphonePermissionStatus;
  static PermissionStatus? storagePermissionStatus;
  static PermissionStatus? photosPermissionStatus;
  static PermissionStatus? photoManagerPermissionStatus;

  static void init() async {
    await checkStoragePermission();
    await checkCameraPermission();
    await checkMicrophonePermission();
    await checkPhotosPermission();
  }

  static Future<PermissionStatus> requestStoragePermission() async {
    return await Permission.storage.request();
  }

  static Future<PermissionStatus> requestCameraPermission() async {
    return await Permission.camera.request();
  }

  static Future<PermissionStatus> requestMicrophonePermission() async {
    return await Permission.microphone.request();
  }

  static Future<PermissionStatus> requestPhotosPermission() async {
    return await Permission.photos.request();
  }

  static Future<PermissionStatus> checkStoragePermission() async {
    return storagePermissionStatus = await Permission.storage.status;
  }

  static Future<PermissionStatus> checkCameraPermission() async {
    return cameraPermissionStatus = await Permission.camera.status;
  }

  static Future<PermissionStatus> checkMicrophonePermission() async {
    return microphonePermissionStatus = await Permission.microphone.status;
  }

  static Future<PermissionStatus> checkPhotosPermission() async {
    return photosPermissionStatus = await Permission.photos.status;
  }

  void handlePermissionStatus(PermissionStatus status, String type) {
    switch (status) {
      case PermissionStatus.granted:
        Get.snackbar('Success', '$type permission granted');
        break;
      case PermissionStatus.denied:
        if (type == "Camera") {
          Permission.camera.request();
        } else if (type == "Strorage") {
          Permission.storage.request();
        } else if (type == "Microphone") {
          Permission.microphone.request();
        } else if (type == "Photos") {
          Permission.photos.request();
        }
        break;
      case PermissionStatus.permanentlyDenied:
        Get.snackbar(
          'Error',
          '$type permission permanently denied. Please enable it from settings.',
          mainButton: TextButton(
            onPressed: () {
              openAppSettings();
            },
            child: const Text('Open Settings'),
          ),
        );
        break;
      case PermissionStatus.restricted:
        Get.snackbar('Error', '$type permission is restricted');
        break;
      case PermissionStatus.limited:
        Get.snackbar('Error', '$type permission is limited');
        break;
      default:
    }
  }
}

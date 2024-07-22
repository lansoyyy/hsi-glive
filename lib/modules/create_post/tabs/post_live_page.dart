import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/modules/create_post/controller/create_post_controller.dart';
import 'package:glive/modules/create_post/widgets/camera_access_widget.dart';
import 'package:glive/widgets/AppPageBackground.dart';

class PostLivePage extends StatelessWidget {
  PostLivePage({super.key});
  final CreatePostController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppPageBackground(
        child: Obx(() => controller.camera.isCameraGranted.value == false && controller.camera.isMicrophoneGranted.value == false
            ? CameraAccessWidget()
            : const Center(child: Text("LIVE POST"))),
      ),
    );
  }
}

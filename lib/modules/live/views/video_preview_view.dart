import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glive/models/app/LiveStreamState.dart';
import 'package:glive/modules/live/controller/camera_live_controller.dart';
import 'package:glive/modules/live/controller/video_live_controller.dart';
import 'package:glive/widgets/AppPageBackground.dart';

class VideoPreviewView extends StatefulWidget {
  final LiveStreamTextureMixin textureManager;
  final LiveStreamState state;

  const VideoPreviewView({
    super.key,
    required this.textureManager,
    required this.state,
  });
  @override
  State<VideoPreviewView> createState() => _VideoPreviewViewState();
}

class _VideoPreviewViewState extends State<VideoPreviewView> {
  final VideoLiveController videoLiveController = Get.find();

  int? _textureId;

  @override
  void initState() {
    super.initState();

    if (widget.textureManager.textureId == null) {
      _registerTexture();
    } else {
      _textureId = widget.textureManager.textureId;
    }
  }

  void _updateTextureSize() {
    final mediaSize = MediaQuery.of(context).size;

    widget.textureManager.updateTextureSize(mediaSize);
  }

  void _registerTexture() async {
    final textureId = await widget.textureManager.registerTexture();
    setState(() {
      _textureId = textureId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_textureId == null) {
      return const Center(
        child: Text("No available video preview.\nProbably this device "
            "does not support video preview."),
      );
    }
    _updateTextureSize();

    final orientation = MediaQuery.of(context).orientation;
    final resolution = widget.state.videoResolution;
    final aspectRatio = orientation == Orientation.portrait ? 1 / resolution.aspectRatio : resolution.aspectRatio;
    log("aspectRatio $aspectRatio");
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: AppPageBackground(
        child: Align(
          child: Obx(
            () => AspectRatio(
              aspectRatio: videoLiveController.selectedtedLive.value == 0 || videoLiveController.selectedtedLive.value == 2
                  ? aspectRatio
                  : videoLiveController.multiLiveAspectRatio.value,
              child: Texture(
                textureId: _textureId!,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

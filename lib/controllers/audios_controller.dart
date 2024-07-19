import 'dart:developer';

import 'package:audioplayers/audioplayers.dart';

import 'package:get/get.dart';

class AudioController extends GetxController {
  AudioPlayer audioPlayer = AudioPlayer();
  RxBool isAudioPlaying = false.obs;
  RxString currentTrack = ''.obs;
  RxBool isAudioLoading = false.obs;

  void playAudio(String url) async {
    isAudioLoading.value = true;
    if (currentTrack.value != url) {
      await audioPlayer.stop();
      currentTrack.value = url;
      await audioPlayer.play(UrlSource(url));
      isAudioPlaying.value = true;
    } else {
      if (isAudioPlaying.value) {
        await audioPlayer.pause();
        isAudioPlaying.value = false;
      } else {
        await audioPlayer.resume();
        isAudioPlaying.value = true;
      }
    }
    isAudioLoading.value = false;
  }

  void stopAudio() async {
    await audioPlayer.stop();
    isAudioPlaying.value = false;
    currentTrack.value = '';
  }

  bool isCurrentlyPlaying(String url) {
    return isAudioPlaying.value && currentTrack.value == url;
  }

  @override
  void onInit() {
    // TODO: implement onInit
    log("Init AudioController ");
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    log("Close AudioController ");
    super.onClose();
  }
}

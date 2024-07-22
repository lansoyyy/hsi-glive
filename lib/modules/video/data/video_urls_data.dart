import 'package:get/get.dart';

RxList<String> videoUrls = <String>[].obs;
RxBool isLoading = false.obs;

initializeVideos() {
  videoUrls.value = [
    'https://ksmiguel.com/unleash/files/0.mp4',
    'https://ksmiguel.com/unleash/files/1.mp4',
    'https://ksmiguel.com/unleash/files/2.mp4',
    'https://ksmiguel.com/unleash/files/3.mp4',
    'https://ksmiguel.com/unleash/files/4.mp4',
  ];
}

fetchMoreVideos() async {
  if (isLoading.value) return;
  isLoading.value = true;
  await Future.delayed(const Duration(seconds: 1));
  List<String> newVideoUrls = [
    'https://ksmiguel.com/unleash/files/5.mp4',
    'https://ksmiguel.com/unleash/files/6.mp4',
    'https://ksmiguel.com/unleash/files/7.mp4',
    'https://ksmiguel.com/unleash/files/8.mp4',
    'https://ksmiguel.com/unleash/files/9.mp4',
  ];
  videoUrls.addAll(newVideoUrls);
  isLoading.value = false;
}

fetchMoreVideos2() async {
  if (isLoading.value) return;
  isLoading.value = true;
  await Future.delayed(const Duration(seconds: 1));
  List<String> newVideoUrls = [
    'https://ksmiguel.com/unleash/files/10.mp4',
    'https://ksmiguel.com/unleash/files/11.mp4',
    'https://ksmiguel.com/unleash/files/12.mp4',
    'https://ksmiguel.com/unleash/files/13.mp4',
    'https://ksmiguel.com/unleash/files/15.mp4',
  ];
  videoUrls.addAll(newVideoUrls);
  isLoading.value = false;
}

omRefreshVideos() async {
  if (isLoading.value) return;
  isLoading.value = true;
  await Future.delayed(const Duration(seconds: 1));
  List<String> newVideoUrls = [
    'https://ksmiguel.com/unleash/files/16.mp4',
    'https://ksmiguel.com/unleash/files/17.mp4',
    'https://ksmiguel.com/unleash/files/18.mp4',
    'https://ksmiguel.com/unleash/files/19.mp4',
    'https://ksmiguel.com/unleash/files/20.mp4',
  ];
  videoUrls.addAll(newVideoUrls);
  isLoading.value = false;
}

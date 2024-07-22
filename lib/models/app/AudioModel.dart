// ignore_for_file: file_names

class AudioModel {
  String title;
  String description;
  String icon;
  String audio;
  bool isPlaying;

  AudioModel({
    required this.title,
    required this.description,
    required this.icon,
    required this.audio,
    required this.isPlaying,
  });
}

class AudioMood {
  String title;
  String description;

  AudioMood({
    required this.title,
    required this.description,
  });
}

class HashtagData {
  String id;
  String title;

  HashtagData({
    required this.id,
    required this.title,
  });
}

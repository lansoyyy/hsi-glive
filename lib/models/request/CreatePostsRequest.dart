// ignore_for_file: file_names

import 'dart:io';

class CreatePostsRequest {
  final File thumbnail;
  final List<File> media;
  final String title;
  final String description;
  final String category;
  final String privacySetting;
  final bool isLive;

  CreatePostsRequest({
    required this.thumbnail,
    required this.media,
    required this.title,
    required this.description,
    required this.category,
    required this.privacySetting,
    required this.isLive,
  });

  factory CreatePostsRequest.fromJson(Map<String, dynamic> json) => createPostsRequestFromJson(json);

  Map<String, dynamic> toJson() => createPostsRequestToJson(this);

  static CreatePostsRequest createPostsRequestFromJson(Map<String, dynamic> json) => CreatePostsRequest(
        thumbnail: json['thumbnail'] as File,
        media: List<File>.from(json["media"].map((x) => x)).toList(),
        title: json['title'] as String,
        description: json['description'] as String,
        category: json['category'] as String,
        privacySetting: json['privacySetting'] as String,
        isLive: json['isLive'] as bool,
      );

  Map<String, dynamic> createPostsRequestToJson(CreatePostsRequest instance) => <String, dynamic>{
        "thumbnail": instance.thumbnail,
        "media": instance.media,
        "title": instance.title,
        "description": instance.description,
        "category": instance.category,
        "privacySetting": instance.privacySetting,
        "isLive": instance.isLive,
      };
}

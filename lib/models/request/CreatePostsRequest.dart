// ignore_for_file: file_names

import 'dart:io';

import 'package:dio/dio.dart';

class CreatePostsRequest {
  final String title;
  final String description;
  final String privacySetting;
  final List<File> media;
  final String isLive;
  final List<String> category;
  final String musicId;
  final String isAllowedComments;
  final File thumbnail;

  CreatePostsRequest({
    required this.title,
    required this.description,
    required this.privacySetting,
    required this.media,
    required this.isLive,
    required this.category,
    required this.musicId,
    required this.isAllowedComments,
    required this.thumbnail,
  });

  factory CreatePostsRequest.fromJson(Map<String, dynamic> json) => createPostsRequestFromJson(json);

  Map<String, dynamic> toJson() => createPostsRequestToJson(this);

  static CreatePostsRequest createPostsRequestFromJson(Map<String, dynamic> json) => CreatePostsRequest(
        title: json['title'] as String,
        description: json['description'] as String,
        privacySetting: json['privacySetting'] as String,
        media: List<File>.from(json["media"].map((x) => x)).toList(),
        isLive: json['isLive'] as String,
        category: List<String>.from(json["category"].map((x) => x)).toList(),
        musicId: json["musicId"],
        isAllowedComments: json["isAllowedComments"] as String,
        thumbnail: json['thumbnail'] as File,
      );

  Map<String, dynamic> createPostsRequestToJson(CreatePostsRequest instance) => <String, dynamic>{
        "title": instance.title,
        "description": instance.description,
        "privacySetting": instance.privacySetting,
        "media": instance.media,
        "isLive": instance.isLive,
        "category": instance.category,
        "musicId": instance.musicId,
        "isAllowedComments": instance.isAllowedComments,
        "thumbnail": instance.thumbnail,
      };

  Future<FormData> toFormData() async {
    List<MultipartFile> mediaFiles = [];
    for (var file in media) {
      mediaFiles.add(
        MultipartFile.fromFileSync(
          file.path,
          filename: file.path.split('/').last,
        ),
      );
    }

    return FormData.fromMap({
      'title': title,
      'description': description,
      'privacySetting': privacySetting,
      'media': mediaFiles,
      'isLive': isLive,
      'category': category,
      'musicId': musicId,
      "isAllowedComments": isAllowedComments,
      'thumbnail': MultipartFile.fromFileSync(
        thumbnail.path,
        filename: thumbnail.path.split('/').last,
      ),
    });
  }
}

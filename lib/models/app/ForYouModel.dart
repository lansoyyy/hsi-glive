// ignore_for_file: file_names

import 'package:glive/models/app/Author.dart';
import 'package:glive/models/app/Media.dart';

class ForYouModel {
  final String id;
  final Author author;
  final String title;
  final List<String> tags;
  final List<Media> media;
  final String music;
  int likes;
  final int comments;
  final int views;
  final int shares;
  bool isLike;

  ForYouModel(
      {required this.id,
      required this.author,
      required this.title,
      required this.tags,
      required this.media,
      required this.music,
      required this.likes,
      required this.comments,
      required this.views,
      required this.shares,
      required this.isLike});
  factory ForYouModel.fromJson(Map<String, dynamic> json) => forYouModelFromJson(json);

  Map<String, dynamic> toJson() => forYouModelToJson(this);

  static ForYouModel forYouModelFromJson(Map<String, dynamic> json) => ForYouModel(
        id: json["id"],
        author: Author.fromJson(json["author"]),
        title: json["title"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        music: json["music"],
        likes: json["likes"],
        comments: json["comments"],
        views: json["views"],
        shares: json["shares"],
        isLike: json["isLike"],
      );

  Map<String, dynamic> forYouModelToJson(ForYouModel instance) => <String, dynamic>{
        "id": instance.id,
        "author": instance.author.toJson(),
        "title": instance.title,
        "tags": instance.tags,
        "media": instance.media,
        "music": instance.music,
        "likes": instance.likes,
        "comments": instance.comments,
        "views": instance.views,
        "shares": instance.shares,
        "isLike": instance.isLike,
      };
  List<Object> get props => [
        id,
        author,
        title,
        tags,
        media,
        music,
        likes,
        comments,
        views,
        shares,
        isLike,
      ];
}

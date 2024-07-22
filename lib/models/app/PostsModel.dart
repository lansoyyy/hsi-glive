// ignore_for_file: file_names

import 'package:glive/models/app/Author.dart';
import 'package:glive/models/app/Media.dart';

class PostsModel {
  final String id;
  final Author author;
  final String title;
  final List<String> tags;
  final List<Media> media;
  final String music;
  final int likes;
  final int comments;
  final int views;
  final int shares;
  final bool isLike;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostsModel(
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
      required this.isLike,
      required this.createdAt,
      required this.updatedAt});
  factory PostsModel.fromJson(Map<String, dynamic> json) => postsModelFromJson(json);

  Map<String, dynamic> toJson() => postsModelToJson(this);

  static PostsModel postsModelFromJson(Map<String, dynamic> json) => PostsModel(
        id: json["id"] ?? "",
        author: Author.fromJson(json["author"]),
        title: json["title"] ?? "",
        tags: List<String>.from(json["tags"].map((x) => x)),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))),
        music: json["music"],
        likes: json["likes"] as int,
        comments: json["comments"] as int,
        views: json["views"] as int,
        shares: json["shares"] as int,
        isLike: json["isLike"] as bool,
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> postsModelToJson(PostsModel instance) => <String, dynamic>{
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
        "createdAt": instance.createdAt.toIso8601String(),
        "updatedAt": instance.updatedAt.toIso8601String(),
      };
  List<Object> get props => [
        id,
        author,
        title,
        tags,
        media,
        likes,
        music,
        comments,
        views,
        shares,
        isLike,
        createdAt,
        updatedAt,
      ];
}

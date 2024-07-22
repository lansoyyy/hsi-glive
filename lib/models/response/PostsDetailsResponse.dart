// ignore_for_file: file_names

import 'package:glive/models/app/Author.dart';
import 'package:glive/models/app/Media.dart';

class PostsDetailsResponse {
  final String id;
  final Author author;
  final String title;
  final List<String> tags;
  final List<Media> media;
  final int likes;
  final int comments;
  final int views;
  final int shares;
  final bool isLike;
  final DateTime createdAt;
  final DateTime updatedAt;

  PostsDetailsResponse({
    required this.id,
    required this.author,
    required this.title,
    required this.tags,
    required this.media,
    required this.likes,
    required this.comments,
    required this.views,
    required this.shares,
    required this.isLike,
    required this.createdAt,
    required this.updatedAt,
  });

  factory PostsDetailsResponse.fromJson(Map<String, dynamic> json) => postsDetailsResponseFromJson(json);

  Map<String, dynamic> toJson() => postsDetailsResponseToJson(this);

  static PostsDetailsResponse postsDetailsResponseFromJson(Map<String, dynamic> json) => PostsDetailsResponse(
        id: json["id"] ?? "",
        author: Author.fromJson(json["author"]),
        title: json["title"] ?? "",
        tags: List<String>.from(json["tags"].map((x) => x)).toList(),
        media: List<Media>.from(json["media"].map((x) => Media.fromJson(x))).toList(),
        likes: json["likes"],
        comments: json["comments"],
        views: json["views"],
        shares: json["shares"],
        isLike: json["isLike"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> postsDetailsResponseToJson(PostsDetailsResponse instance) => <String, dynamic>{
        "id": instance.id,
        "author": instance.author.toJson(),
        "title": instance.title,
        "tags": instance.tags,
        "media": instance.media,
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
        comments,
        views,
        shares,
        isLike,
        createdAt,
        updatedAt,
      ];
}

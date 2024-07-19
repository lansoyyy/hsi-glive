// ignore_for_file: file_names

import 'package:glive/models/app/FollowingModel.dart';

class PostsFollowingResponse {
  final List<FollowingModel> list;
  final int count;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  PostsFollowingResponse({
    required this.list,
    required this.count,
    required this.limit,
    required this.totalPages,
    required this.page,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });
  factory PostsFollowingResponse.fromJson(Map<String, dynamic> json) => postsFollowingResponseFromJson(json);

  Map<String, dynamic> toJson() => postsFollowingResponseToJson(this);

  static PostsFollowingResponse postsFollowingResponseFromJson(Map<String, dynamic> json) => PostsFollowingResponse(
        list: List<FollowingModel>.from(json["list"].map((x) => FollowingModel.fromJson(x))),
        count: json["count"] as int,
        limit: json["limit"] as int,
        totalPages: json["totalPages"] as int,
        page: json["page"] as int,
        pagingCounter: json["pagingCounter"] as int,
        hasPrevPage: json["hasPrevPage"] as bool,
        hasNextPage: json["hasNextPage"] as bool,
        prevPage: json["prevPage"] == null ? json["prevPage"] : "null",
        nextPage: json["nextPage"] == null ? json["nextPage"] : "null",
      );

  Map<String, dynamic> postsFollowingResponseToJson(PostsFollowingResponse instance) => <String, dynamic>{
        "list": instance.list,
        "count": instance.count,
        "limit": instance.limit,
        "totalPages": instance.totalPages,
        "page": instance.page,
        "pagingCounter": instance.pagingCounter,
        "hasPrevPage": instance.hasPrevPage,
        "hasNextPage": instance.hasNextPage,
        "prevPage": instance.prevPage,
        "nextPage": instance.nextPage,
      };
  List<Object> get props => [
        list,
        count,
        limit,
        totalPages,
        page,
        pagingCounter,
        hasPrevPage,
        hasNextPage,
        prevPage,
        nextPage,
      ];
}

// ignore_for_file: file_names

import 'package:glive/models/app/ForYouModel.dart';

class PostsForYouResponse {
  final List<ForYouModel> list;
  final int count;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  PostsForYouResponse({
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
  factory PostsForYouResponse.fromJson(Map<String, dynamic> json) => postsForYouResponseFromJson(json);

  Map<String, dynamic> toJson() => postsForYouResponseToJson(this);

  static PostsForYouResponse postsForYouResponseFromJson(Map<String, dynamic> json) => PostsForYouResponse(
        list: List<ForYouModel>.from(json["list"].map((x) => ForYouModel.fromJson(x))),
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

  Map<String, dynamic> postsForYouResponseToJson(PostsForYouResponse instance) => <String, dynamic>{
        "list": List<ForYouModel>.from(instance.list.map((x) => x.toJson())),
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

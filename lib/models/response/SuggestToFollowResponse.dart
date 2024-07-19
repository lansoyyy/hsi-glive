// ignore_for_file: file_names

import 'dart:convert';

import 'package:glive/models/app/SuggestToFollowModel.dart';

SuggestToFollowResponse suggestToFollowResponseFromJson(String str) => SuggestToFollowResponse.fromJson(json.decode(str));

String suggestToFollowResponseToJson(SuggestToFollowResponse data) => json.encode(data.toJson());

class SuggestToFollowResponse {
  final List<SuggestToFollowModel> list;
  final int count;
  final int limit;
  final int page;
  final int totalPages;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final dynamic nextPage;

  SuggestToFollowResponse({
    required this.list,
    required this.count,
    required this.limit,
    required this.page,
    required this.totalPages,
    required this.pagingCounter,
    required this.hasPrevPage,
    required this.hasNextPage,
    required this.prevPage,
    required this.nextPage,
  });
  factory SuggestToFollowResponse.fromJson(Map<String, dynamic> json) => suggestToFollowResponseFromJson(json);

  Map<String, dynamic> toJson() => suggestToFollowResponseToJson(this);

  static SuggestToFollowResponse suggestToFollowResponseFromJson(Map<String, dynamic> json) => SuggestToFollowResponse(
        list: List<SuggestToFollowModel>.from(json["list"].map((x) => SuggestToFollowModel.fromJson(x))),
        count: json["count"],
        limit: json["limit"],
        page: json["page"],
        totalPages: json["totalPages"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"] == null ? json["prevPage"] : "null",
        nextPage: json["nextPage"] == null ? json["nextPage"] : "null",
      );

  Map<String, dynamic> suggestToFollowResponseToJson(SuggestToFollowResponse instance) => <String, dynamic>{
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

// ignore_for_file: file_names

import 'package:glive/models/app/InterestModel.dart';

class InterestListResponse {
  final List<InterestModel> list;
  final int count;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final int prevPage;
  final int nextPage;

  InterestListResponse({
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
  factory InterestListResponse.fromJson(Map<String, dynamic> json) => interestListResponseFromJson(json);

  Map<String, dynamic> toJson() => interestListRResponseToJson(this);

  static InterestListResponse interestListResponseFromJson(Map<String, dynamic> json) => InterestListResponse(
        list: (json['list'] as List<dynamic>).map((e) => InterestModel.fromJson(e as Map<String, dynamic>)).toList(),
        count: json["count"] as int,
        limit: json["limit"] as int,
        totalPages: json["totalPages"] as int,
        page: json["page"] as int,
        pagingCounter: json["pagingCounter"] as int,
        hasPrevPage: json["hasPrevPage"] as bool,
        hasNextPage: json["hasNextPage"] as bool,
        prevPage: json["prevPage"] as int,
        nextPage: json["nextPage"] as int,
      );

  Map<String, dynamic> interestListRResponseToJson(InterestListResponse instance) => <String, dynamic>{
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

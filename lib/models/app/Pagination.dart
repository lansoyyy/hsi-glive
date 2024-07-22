// ignore_for_file: file_names

class Pagination {
  final List<dynamic> list;
  final int count;
  final int limit;
  final int totalPages;
  final int page;
  final int pagingCounter;
  final bool hasPrevPage;
  final bool hasNextPage;
  final dynamic prevPage;
  final int nextPage;

  Pagination({
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

  Pagination paginationFromJson(Map<String, dynamic> json) => Pagination(
        list: List<dynamic>.from(json["list"].map((x) => x)),
        count: json["count"],
        limit: json["limit"],
        totalPages: json["totalPages"],
        page: json["page"],
        pagingCounter: json["pagingCounter"],
        hasPrevPage: json["hasPrevPage"],
        hasNextPage: json["hasNextPage"],
        prevPage: json["prevPage"],
        nextPage: json["nextPage"],
      );
  Map<String, dynamic> paginationToJson(Pagination instance) => <String, dynamic>{
        "list": List<dynamic>.from(list.map((x) => x)),
        "count": count,
        "limit": limit,
        "totalPages": totalPages,
        "page": page,
        "pagingCounter": pagingCounter,
        "hasPrevPage": hasPrevPage,
        "hasNextPage": hasNextPage,
        "prevPage": prevPage,
        "nextPage": nextPage,
      };
}

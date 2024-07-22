// ignore_for_file: file_names

class ContentResponse {
  final bool acknowledged;
  final int modifiedCount;
  final String upsertedId;
  final int upsertedCount;
  final int matchedCount;

  ContentResponse({
    required this.acknowledged,
    required this.modifiedCount,
    required this.upsertedId,
    required this.upsertedCount,
    required this.matchedCount,
  });
  factory ContentResponse.fromJson(Map<String, dynamic> json) => contentResponseFromJson(json);

  Map<String, dynamic> toJson() => interestListRResponseToJson(this);

  static ContentResponse contentResponseFromJson(Map<String, dynamic> json) => ContentResponse(
        acknowledged: json["acknowledged"],
        modifiedCount: json["modifiedCount"],
        upsertedId: json["upsertedId"],
        upsertedCount: json["upsertedCount"],
        matchedCount: json["matchedCount"],
      );

  Map<String, dynamic> interestListRResponseToJson(ContentResponse instance) => <String, dynamic>{
        "acknowledged": instance.acknowledged,
        "modifiedCount": instance.modifiedCount,
        "upsertedId": instance.upsertedId,
        "upsertedCount": instance.upsertedCount,
        "matchedCount": instance.matchedCount,
      };
  List<Object> get props => [acknowledged, modifiedCount, upsertedId, upsertedCount, matchedCount];
}

// ignore_for_file: file_names

class ContentRequest {
  final List<String> tags;

  ContentRequest({
    required this.tags,
  });
  factory ContentRequest.fromJson(Map<String, dynamic> json) => contentRequestFromJson(json);

  Map<String, dynamic> toJson() => contentRequestToJson(this);

  static ContentRequest contentRequestFromJson(Map<String, dynamic> json) => ContentRequest(
        tags: List<String>.from(json["tags"].map((x) => x)).toList(),
      );

  Map<String, dynamic> contentRequestToJson(ContentRequest instance) => <String, dynamic>{
        "tags": instance.tags,
      };
}

// ignore_for_file: file_names

class EditPostsRequest {
  final String title;
  final List<String> tags;
  final String description;
  final String privacySetting;

  EditPostsRequest({
    required this.title,
    required this.tags,
    required this.description,
    required this.privacySetting,
  });
  factory EditPostsRequest.fromJson(Map<String, dynamic> json) => editPostsRequestFromJson(json);

  Map<String, dynamic> toJson() => editPostsRequestToJson(this);

  static EditPostsRequest editPostsRequestFromJson(Map<String, dynamic> json) => EditPostsRequest(
        title: json["title"] as String,
        tags: List<String>.from(json["tags"].map((x) => x)),
        description: json["description"] as String,
        privacySetting: json["privacySetting"] as String,
      );

  Map<String, dynamic> editPostsRequestToJson(EditPostsRequest instance) => <String, dynamic>{
        "title": instance.title,
        "tags": instance.tags,
        "description": instance.description,
        "privacySetting": instance.privacySetting,
      };
}

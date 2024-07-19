// ignore_for_file: file_names

class Media {
  final String? url;
  final String? type;
  final String? placeholder;
  final String? thumbnail;

  Media({
    required this.url,
    required this.type,
    required this.placeholder,
    required this.thumbnail,
  });
  factory Media.fromJson(Map<String, dynamic> json) => mediaModelFromJson(json);

  Map<String, dynamic> toJson() => mediaModelToJson(this);

  static Media mediaModelFromJson(Map<String, dynamic> json) => Media(
        url: json["url"] ?? "",
        type: json["type"] ?? "",
        placeholder: json["placeholder"] ?? "",
        thumbnail: json["thumbnail"] ?? "",
      );

  Map<String, dynamic> mediaModelToJson(Media instance) => <String, dynamic>{
        "url": instance.url,
        "type": instance.type,
        "placeholder": instance.placeholder,
        "thumbnail": instance.thumbnail,
      };
  List<Object> get props => [
        url!,
        type!,
        placeholder!,
        thumbnail!,
      ];
}

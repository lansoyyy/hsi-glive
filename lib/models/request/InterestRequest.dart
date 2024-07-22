// ignore_for_file: file_names

class InterestRequest {
  final List<String> interests;

  InterestRequest({
    required this.interests,
  });
  factory InterestRequest.fromJson(Map<String, dynamic> json) => interestRequestFromJson(json);

  Map<String, dynamic> toJson() => interestRequestToJson(this);

  static InterestRequest interestRequestFromJson(Map<String, dynamic> json) => InterestRequest(
        interests: List<String>.from(json["interests"].map((x) => x)).toList(),
      );

  Map<String, dynamic> interestRequestToJson(InterestRequest instance) => <String, dynamic>{
        "interests": instance.interests,
      };
}

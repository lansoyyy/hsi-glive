// ignore_for_file: file_names

class FollowedUserModel {
  final String follower;
  final String followed;
  final String type;
  final String id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final String followedUserModelId;

  FollowedUserModel({
    required this.follower,
    required this.followed,
    required this.type,
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.followedUserModelId,
  });
  factory FollowedUserModel.fromJson(Map<String, dynamic> json) => followedUserModelFromJson(json);

  Map<String, dynamic> toJson() => followingModelToJson(this);

  static FollowedUserModel followedUserModelFromJson(Map<String, dynamic> json) => FollowedUserModel(
        follower: json["follower"],
        followed: json["followed"],
        type: json["type"],
        id: json["_id"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        followedUserModelId: json["id"],
      );

  Map<String, dynamic> followingModelToJson(FollowedUserModel instance) => <String, dynamic>{
        "follower": instance.follower,
        "followed": instance.followed,
        "type": instance.type,
        "_id": instance.id,
        "createdAt": instance.createdAt.toIso8601String(),
        "updatedAt": instance.updatedAt.toIso8601String(),
        "__v": instance.v,
        "id": instance.followedUserModelId,
      };
  List<Object> get props => [
        follower,
        followed,
        type,
        id,
        createdAt,
        updatedAt,
        v,
        followedUserModelId,
      ];
}

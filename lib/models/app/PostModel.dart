// ignore_for_file: file_names

import 'dart:convert';

PostModelData postModelDataFromJson(String str) => PostModelData.fromJson(json.decode(str));

String postModelDataToJson(PostModelData data) => json.encode(data.toJson());

class PostModelData {
  List<PostModel> postModel;

  PostModelData({
    required this.postModel,
  });

  factory PostModelData.fromJson(Map<String, dynamic> json) => PostModelData(
        postModel: List<PostModel>.from(json["post_model"].map((x) => PostModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "post_model": List<dynamic>.from(postModel.map((x) => x.toJson())),
      };
}

class PostModel {
  String postId;
  String postTitle;
  String postDescription;
  List<PostMediaModel> postMedias;
  UserModel userModel;
  String likesCount;
  String commentsCount;
  String giftCount;
  String shareCount;

  PostModel({
    required this.postId,
    required this.postTitle,
    required this.postDescription,
    required this.postMedias,
    required this.userModel,
    required this.likesCount,
    required this.commentsCount,
    required this.giftCount,
    required this.shareCount,
  });

  factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
        postId: json["postId"],
        postTitle: json["postTitle"],
        postDescription: json["postDescription"],
        postMedias: List<PostMediaModel>.from(json["postMedias"].map((x) => PostMediaModel.fromJson(x))),
        userModel: UserModel.fromJson(json["userModel"]),
        likesCount: json["likesCount"],
        commentsCount: json["commentsCount"],
        giftCount: json["giftCount"],
        shareCount: json["shareCount"],
      );

  Map<String, dynamic> toJson() => {
        "postId": postId,
        "postTitle": postTitle,
        "postDescription": postDescription,
        "postMedias": List<dynamic>.from(postMedias.map((x) => x.toJson())),
        "userModel": userModel.toJson(),
        "likesCount": likesCount,
        "commentsCount": commentsCount,
        "giftCount": giftCount,
        "shareCount": shareCount,
      };
}

class PostMediaModel {
  String mediaId;
  String postId;
  String createdAt;
  String updatedAt;
  PostMediaUrlModel postMediaUrl;
  List<CommentsModel> comments;

  PostMediaModel({
    required this.mediaId,
    required this.postId,
    required this.createdAt,
    required this.updatedAt,
    required this.postMediaUrl,
    required this.comments,
  });

  factory PostMediaModel.fromJson(Map<String, dynamic> json) => PostMediaModel(
        mediaId: json["mediaId"],
        postId: json["postId"],
        createdAt: json["createdAt"],
        updatedAt: json["updatedAt"],
        postMediaUrl: PostMediaUrlModel.fromJson(json["postMediaUrl"]),
        comments: List<CommentsModel>.from(json["comments"].map((x) => CommentsModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "mediaId": mediaId,
        "postId": postId,
        "createdAt": createdAt,
        "updatedAt": updatedAt,
        "postMediaUrl": postMediaUrl.toJson(),
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
      };
}

class CommentsModel {
  String commentId;
  String postId;
  String description;
  UserModel userModel;

  CommentsModel({
    required this.commentId,
    required this.postId,
    required this.description,
    required this.userModel,
  });

  factory CommentsModel.fromJson(Map<String, dynamic> json) => CommentsModel(
        commentId: json["commentId"],
        postId: json["postId"],
        description: json["description"],
        userModel: UserModel.fromJson(json["userModel"]),
      );

  Map<String, dynamic> toJson() => {
        "commentId": commentId,
        "postId": postId,
        "description": description,
        "userModel": userModel.toJson(),
      };
}

class UserModel {
  int id;
  String avatar;
  String firstName;
  String lastName;
  String phoneNumber;
  String followersCount;
  bool isActive;

  UserModel({
    required this.id,
    required this.avatar,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.followersCount,
    required this.isActive,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json["id"],
        avatar: json["avatar"],
        firstName: json["firstName"],
        lastName: json["lastName"],
        phoneNumber: json["phoneNumber"],
        followersCount: json["followersCount"],
        isActive: json["isActive"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "avatar": avatar,
        "firstName": firstName,
        "lastName": lastName,
        "phoneNumber": phoneNumber,
        "followersCount": followersCount,
        "isActive": isActive,
      };
}

class PostMediaUrlModel {
  String mediaUrls;
  String mediaThumbnail;
  MediaType mediaType;

  PostMediaUrlModel({
    required this.mediaUrls,
    required this.mediaThumbnail,
    required this.mediaType,
  });

  factory PostMediaUrlModel.fromJson(Map<String, dynamic> json) => PostMediaUrlModel(
        mediaUrls: json["mediaUrls"],
        mediaThumbnail: json["mediaThumbnail"],
        mediaType: json["mediaType"] as MediaType,
      );

  Map<String, dynamic> toJson() => {
        "mediaUrls": mediaUrls,
        "mediaThumbnail": mediaThumbnail,
        "mediaType": mediaType,
      };
}

enum MediaType { image, video }

// class PostModel {
//   String postId;
//   String postTitle;
//   String postDescription;
//   List<PostMediaModel> postMedias;
//   UserModel userModel;
//   String likesCount;
//   String commentsCount;
//   String giftCount;
//   String shareCount;

//   PostModel({
//     required this.postId,
//     required this.postTitle,
//     required this.postDescription,
//     required this.postMedias,
//     required this.userModel,
//     required this.likesCount,
//     required this.commentsCount,
//     required this.giftCount,
//     required this.shareCount,
//   });
//   factory PostModel.fromJson(Map<String, dynamic> json) => PostModel(
//         postId: json["postId"],
//         postTitle: json["postTitle"],
//         postDescription: json["postDescription"],
//         postMedias: json["postMedias"]?.map((x) => PostMediaModel.fromJson(x)).toList() ?? [],
//         userModel: json['userModel'],
//         likesCount: json['likesCount'],
//         commentsCount: json['commentsCount'],
//         giftCount: json['giftCount'],
//         shareCount: json['shareCount'],
//       );

//   Map<String, dynamic> toJson() => {
//         "postId": postId,
//         "postTitle": postTitle,
//         "postDescription": postDescription,
//         "imagpostMediases": postMedias,
//         "userModel": userModel,
//         "likesCount": likesCount,
//         "commentsCount": commentsCount,
//         "giftCount": giftCount,
//         "shareCount": shareCount,
//       };
// }

// class PostMediaModel {
//   String mediaId;
//   String postId;
//   List<PostMedialUrlsModel> postMediaUrls;
//   String createdAt;
//   String? updatedAt;
//   List<CommentsModel> comments;

//   PostMediaModel({
//     required this.mediaId,
//     required this.postId,
//     required this.postMediaUrls,
//     required this.createdAt,
//     this.updatedAt,
//     required this.comments,
//   });

//   factory PostMediaModel.fromJson(Map<String, dynamic> json) => PostMediaModel(
//         mediaId: json["mediaId"] as String,
//         postId: json["postId"] as String,
//         postMediaUrls: json["postMediaUrls"]?.map((x) => PostMedialUrlsModel.fromJson(x)).toList() ?? [],
//         createdAt: json["createdAt"] as String,
//         updatedAt: json["updatedAt"] as String,
//         comments: json["comments"]?.map((x) => CommentsModel.fromJson(x)).toList() ?? [],
//       );
//   Map<String, dynamic> toJson() => {
//         "mediaId": mediaId,
//         "postId": postId,
//         "postMediaUrls": postMediaUrls,
//         "createdAt": createdAt,
//         "updatedAt": updatedAt,
//         "comments": comments,
//       };
// }

// class PostMedialUrlsModel {
//   String medialUrls;
//   final MediaType mediaType;

//   PostMedialUrlsModel({required this.medialUrls, required this.mediaType});

//   factory PostMedialUrlsModel.fromJson(Map<String, dynamic> json) => PostMedialUrlsModel(
//         medialUrls: json["medialUrls"] as String,
//         mediaType: json["mediaType"] as MediaType,
//       );
//   Map<String, dynamic> toJson() => {
//         "medialUrls": medialUrls,
//         "mediaType": mediaType,
//       };
// }

// enum MediaType { image, video }

// class CommentsModel {
//   final String commentId;
//   final String postId;
//   String description;
//   UserModel userModel;

//   CommentsModel({required this.commentId, required this.postId, required this.description, required this.userModel});

//   factory CommentsModel.fromJson(Map<String, dynamic> data) => CommentsModel(
//         commentId: data['commentId'],
//         postId: data['postId'],
//         description: data['description'],
//         userModel: data['userModel'],
//       );

//   Map<String, dynamic> toJson() => {
//         'commentId': commentId,
//         'postId': postId,
//         'description': description,
//         "userModel": userModel,
//       };
// }

// class UserModel {
//   final int id;
//   String avatar;
//   String firstName;
//   String lastName;
//   String phoneNumber;
//   String followersCount;
//   final bool isActive;

//   UserModel(
//       {required this.id,
//       required this.avatar,
//       required this.firstName,
//       required this.lastName,
//       required this.phoneNumber,
//       required this.followersCount,
//       this.isActive = true});

//   String get fullName => '$firstName $lastName';

//   factory UserModel.fromJson(Map<String, dynamic> data) => UserModel(
//         id: data['id'],
//         avatar: data['avatar'],
//         firstName: data['firstName'],
//         lastName: data['lastName'],
//         phoneNumber: data['phoneNumber'],
//         followersCount: data['followersCount'],
//         isActive: data['isActive'],
//       );

//   Map<String, dynamic> toJson() => {
//         'id': id,
//         'avatar': avatar,
//         'firstName': firstName,
//         'lastName': lastName,
//         'phoneNumber': phoneNumber,
//         'followersCount': followersCount,
//         'isActive': isActive,
//       };
// }

// To parse this JSON data, do
//
//     final postModelData = postModelDataFromJson(jsonString);
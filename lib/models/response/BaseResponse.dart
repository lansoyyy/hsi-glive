// ignore_for_file: file_names, avoid_shadowing_type_parameters

import 'package:glive/models/app/PostsModel.dart';
import 'package:glive/models/response/ContentResponse.dart';
import 'package:glive/models/response/FollowedUserResponse.dart';
import 'package:glive/models/response/InterestListResponse.dart';
import 'package:glive/models/response/PostsDetailsResponse.dart';
import 'package:glive/models/response/PostsFollowingResponse.dart';
import 'package:glive/models/response/PostsForYouResponse.dart';
import 'package:glive/models/response/SuggestToFollowResponse.dart';

class BaseResponse<T> {
  final int c;
  final String m;
  final T? d;

  BaseResponse(this.c, this.m, this.d);
  factory BaseResponse.fromJson(Map<String, dynamic> json) => baseResponseFromJson<T>(json);

  Map<String, dynamic> toJson() => baseResponseToJson(this);

  static BaseResponse<T> baseResponseFromJson<T>(Map<String, dynamic> json) => BaseResponse<T>(
        json["c"] as int,
        json["m"] as String,
        _dataFromJson(json['d'] as Map<String, dynamic>?),
      );

  Map<String, dynamic> baseResponseToJson<T>(BaseResponse<T> instance) => <String, dynamic>{
        'c': instance.c,
        'm': instance.m,
        'd': _dataToJson(instance.d),
      };
}

T? _dataFromJson<T>(Map<String, dynamic>? json) {
  if (json != null) {
    if (T == InterestListResponse) {
      return InterestListResponse.fromJson(json) as T;
    } else if (T == ContentResponse) {
      return ContentResponse.fromJson(json) as T;
    } else if (T == PostsDetailsResponse) {
      return PostsDetailsResponse.fromJson(json) as T;
    } else if (T == PostsForYouResponse) {
      return PostsForYouResponse.fromJson(json) as T;
    } else if (T == PostsFollowingResponse) {
      return PostsFollowingResponse.fromJson(json) as T;
    } else if (T == SuggestToFollowResponse) {
      return SuggestToFollowResponse.fromJson(json) as T;
    } else if (T == FollowedUseeResponse) {
      return FollowedUseeResponse.fromJson(json) as T;
    } else if (T == PostsModel) {
      return PostsModel.fromJson(json) as T;
    }
    return null;
  } else {
    return null;
  }
}

Object? _dataToJson<T>(T data) {
  if (data is InterestListResponse) {
    return (data).toJson();
  } else if (data is ContentResponse) {
    return (data).toJson();
  } else if (data is PostsDetailsResponse) {
    return (data).toJson();
  } else if (data is PostsForYouResponse) {
    return (data).toJson();
  } else if (data is PostsFollowingResponse) {
    return (data).toJson();
  } else if (data is SuggestToFollowResponse) {
    return (data).toJson();
  } else if (data is FollowedUseeResponse) {
    return (data).toJson();
  } else if (data is PostsModel) {
    return (data).toJson();
  }
  return null;
}

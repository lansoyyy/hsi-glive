// ignore_for_file: file_names, unrelated_type_equality_checks

import 'dart:convert';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:glive/models/request/ContentRequest.dart';
import 'package:glive/models/request/EditPostsRequest.dart';
import 'package:glive/models/request/InterestRequest.dart';
import 'package:glive/models/response/ContentResponse.dart';
import 'package:glive/models/response/FollowedUserResponse.dart';
import 'package:glive/models/response/PostsDetailsResponse.dart';
import 'package:glive/models/response/PostsFollowingResponse.dart';
import 'package:glive/models/response/PostsForYouResponse.dart';
import 'package:glive/models/response/SuggestToFollowResponse.dart';
import 'package:glive/network/AuthInterceptor.dart';

import 'package:glive/models/response/BaseResponse.dart';
import 'package:glive/models/response/InterestListResponse.dart';
import 'package:glive/network/ApiEndpoints.dart';

class ApiImplementation {
  late Dio _dio;
  final Duration _requestTimeout = const Duration(minutes: 2);
  final Map<String, String> headers = {
    "Content-Type": "application/json",
    "Access-Control-Allow-Origin": "*",
  };
  final box = GetStorage();

  ApiImplementation() {
    final options = BaseOptions(connectTimeout: _requestTimeout, receiveTimeout: _requestTimeout, contentType: 'application/json');

    _dio = Dio(options);

    _dio.interceptors.add(AuthInterceptor());
  }
  Future<String> chooseInterest(List<String> interests) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(ApiEndpoints.chooseInterests,
          options: Options(method: 'POST', headers: headers, responseType: ResponseType.plain),
          data: jsonEncode(InterestRequest(interests: interests)));
      return response.data.toString();
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<ContentResponse>> preferredContent(List<String> tags) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        ApiEndpoints.preferredContent,
        options: Options(method: 'POST', headers: headers, responseType: ResponseType.plain),
        data: jsonEncode(ContentRequest(tags: tags)),
      );

      return parseWithGetXResponse<ContentResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<InterestListResponse>> getInterestList() async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        ApiEndpoints.interests,
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<InterestListResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> createPosts(
      String title, String description, String category, String privacySetting, String isLive) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        ApiEndpoints.createPosts,
        options: Options(method: 'POST', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> getPostsDetails(String postsId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.postsDetails}/:$postsId",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> getPostsViews(String postsId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.postsDetails}/:$postsId",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> getPostsPosts(String postsId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.postsDetails}/:$postsId",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> deletePosts(String postsId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.deletePosts}/:$postsId",
        options: Options(method: 'DELETE', headers: headers, responseType: ResponseType.plain),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsDetailsResponse>> editPosts(
      String postsId, String tille, List<String> tags, String description, String privacySetting) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.editPosts}/:$postsId",
        options: Options(method: 'PUT', headers: headers, responseType: ResponseType.plain),
        data: jsonEncode(EditPostsRequest(title: tille, tags: tags, description: description, privacySetting: privacySetting)),
      );
      return parseWithGetXResponse<PostsDetailsResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsForYouResponse>> getPostsForYou(int page, int limit) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.postsForYou}?page=$page&limit=$limit",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      log("postsForYouResponse ${response.data.toString()}");
      return parseWithGetXResponse<PostsForYouResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<PostsFollowingResponse>> getPostsFollowing(int page, int limit) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.postsFollowing}?page=$page &limit=$limit",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      log("postsFollowingResponse ${response.data.toString()}");
      return parseWithGetXResponse<PostsFollowingResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<SuggestToFollowResponse>> getSuggestToFollow(int page, int limit) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.suggestToFololw}?page=$page &limit=$limit",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      log("suggestToFollowResponse ${response.data.toString()}");
      return parseWithGetXResponse<SuggestToFollowResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<SuggestToFollowResponse>> getUsersFollowing(int page, int limit) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.usersFollowing}?page=$page &limit=$limit",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      log("postsFollowingResponse ${response.data.toString()}");
      return parseWithGetXResponse<SuggestToFollowResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<SuggestToFollowResponse>> getUsersFollowers(int page, int limit) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.usersFollowers}?page=$page &limit=$limit",
        options: Options(method: 'GET', headers: headers, responseType: ResponseType.plain),
      );
      log("postsFollowingResponse ${response.data.toString()}");
      return parseWithGetXResponse<SuggestToFollowResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<BaseResponse<FollowedUseeResponse>> followUser(String userId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      await _addSubscriptionKeyToHeader();
      var response = await dio.request(
        "${ApiEndpoints.followUser}/$userId/follow",
        options: Options(method: 'POST', headers: headers, responseType: ResponseType.plain, validateStatus: (status) => true),
      );
      log("followedUserResponse ${response.data.toString()}");
      return parseWithGetXResponse<FollowedUseeResponse>(response: response.data.toString());
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> unfollowUser(String userId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.unfollowUser}/$userId/unfollow",
        options: Options(method: 'DELETE', headers: headers, responseType: ResponseType.plain),
      );
      log("unfollowedUserResponse ${response.data.toString()}");
      return response.data.toString();
    } catch (ex) {
      rethrow;
    }
  }

  Future<String> removeUser(String userId) async {
    try {
      var dio = Dio();
      await _addTokenToHeader();
      var response = await dio.request(
        "${ApiEndpoints.removeUser}/$userId/unfollow",
        options: Options(method: 'DELETE', headers: headers, responseType: ResponseType.plain),
      );
      log("removeUserResponse ${response.data.toString()}");
      return response.data.toString();
    } catch (ex) {
      rethrow;
    }
  }

  _addTokenToHeader() {
    headers["Authorization"] = "Bearer ${box.read("token")}";
  }

  _addSubscriptionKeyToHeader() {
    headers["Ocp-Apim-Subscription-Key"] = "f3afff9001fd47ea9ea6e11255d8445c";
  }

  Future<BaseResponse<T>> parseWithGetXResponse<T>({required String? response}) async {
    if (response != null) {
      return BaseResponse<T>.fromJson(jsonDecode(response));
    } else {
      throw Exception("parseWithGetXResponse strNoInternet");
    }
  }
}

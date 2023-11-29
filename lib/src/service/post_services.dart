import 'dart:convert';
import 'dart:developer';
import 'package:app_pet_care/src/config/app_config.dart';
import 'package:app_pet_care/src/model/post_model.dart';
import 'package:app_pet_care/src/util/account_util.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:get/get.dart';

class PostServices extends GetConnect {
  PostServices() {
    httpClient.baseUrl = AppConfig.apiDomain;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addResponseModifier((request, response) {
      log("${request.method.toUpperCase()}: ${request.url.toString()}",
          name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
      return response;
    });
  }

  Map<String, String> get headers {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${TokenUtil.getAccessToken()}'
    };
    return headers;
  }

  Future<Response> getPostList({int page = 0, int limit = 15}) async {
    Map<String, dynamic> query = {};
    query['page'] = "$page";
    query['limit'] = "$limit";
    log(jsonEncode(query),
        name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await get('/posts', query: query, headers: headers);
  }

  Future<Response> createPost(PostModel postModel) async {
    return await post('/posts', postModel.toJson(), headers: headers);
  }

  Future<Response> updatePost(PostModel postModel) async {
    return await put('/posts/${postModel.id}', postModel.toJson(),
        headers: headers);
  }

  Future<Response>updateReactPost(String postId) async {
    Map<String, dynamic> body = {};
    body['userId'] = AccountUtil.getUserId();
    return await put('/posts/$postId/react', body, headers: headers);
  }
}

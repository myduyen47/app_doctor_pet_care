import 'dart:convert';
import 'dart:developer';
import 'package:app_pet_care/src/config/app_config.dart';
import 'package:app_pet_care/src/model/comments_model.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:get/get.dart';

class CommentsService extends GetConnect {
  CommentsService() {
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

  Future<Response> getCommentsList(
      {int page = 0, int limit = 15, String? postId}) async {
    Map<String, dynamic> query = {};
    query['page'] = "$page";
    query['limit'] = "$limit";
    if (postId != null) {
      query['postId'] = postId;
    }
    log(jsonEncode(query),
        name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await get('/comments', query: query, headers: headers);
  }

  Future<Response> createComments(
      {String? content, String? postId, User? user}) async {
    Map<String, dynamic> body = {};
    if (content != null) {
      body['content'] = content;

      } 
    if (postId != null) {
      body['postId'] = postId;
    }
    if (user != null) {
      body['user'] = user.toJson();
    }
    log(jsonEncode(body),
        name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await post('/comments', body, headers: headers);
      }
}

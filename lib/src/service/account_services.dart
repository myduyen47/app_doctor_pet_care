import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:app_pet_care/src/config/app_config.dart';

import '../util/common_util.dart';
import '../util/token_util.dart';

class AuthService extends GetConnect {
  AuthService() {
    httpClient.baseUrl = AppConfig.apiDomain;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "Bearer ${TokenUtil.getAccessToken()}";
      return request;
    });
    httpClient.addResponseModifier((request, response) {
      log("${request.method.toUpperCase()}: ${request.url.toString()}", name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
      return response;
    });
  }


  Future<Response> login({required String username, required String password}) async {
    Map<String, dynamic> body = {};
    body['username'] = username;
    body['password'] = password;

    log(jsonEncode(body), name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await post('/auth/login', body);
  } 
}

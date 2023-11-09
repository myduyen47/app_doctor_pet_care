import 'dart:developer';

import 'package:app_pet_care/src/config/app_config.dart';
import 'package:app_pet_care/src/util/account_util.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:get/get.dart';

class DoctorServices extends GetConnect {
  DoctorServices () {
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

    Map<String, String> get headers {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${TokenUtil.getAccessToken()}'
    };
    return headers;
  }

  Future<Response> getDoctorInfo() async {
   final id = AccountUtil.getUserDoctorId();
    return await get('/doctors/$id', headers: headers);
  }

}
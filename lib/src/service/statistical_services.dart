import 'dart:convert';
import 'dart:developer';

import 'package:app_pet_care/src/config/app_config.dart';
import 'package:app_pet_care/src/util/account_util.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:get/get.dart';

class StatisticalServices extends GetConnect {
  StatisticalServices() {
       httpClient.baseUrl = AppConfig.apiDomain;
    httpClient.timeout = const Duration(seconds: 30);
    httpClient.addAuthenticator<dynamic>((request) async {
      request.headers['Authorization'] = "Bearer ${TokenUtil.getAccessToken()}";
      return request;
    });
  }

    Map<String, String> get headers {
    Map<String, String> headers = {
      'Authorization': 'Bearer ${TokenUtil.getAccessToken()}'
    };
    return headers;
  }

Future<Response> getStatistical({int? selectedMonth}) async {
  Map<String, dynamic> query = {};
  query['id'] = AccountUtil.getUserDoctorId();

  if (selectedMonth != null) {
    query['month'] = selectedMonth.toString();
  }

  log(jsonEncode(query),
      name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));

  return await get('/appointments/patient-appointments', headers: headers, query: query);
}


}
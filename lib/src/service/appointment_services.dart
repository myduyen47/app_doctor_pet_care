import 'dart:convert';
import 'dart:developer';

import 'package:app_pet_care/src/config/app_config.dart';
import 'package:app_pet_care/src/util/account_util.dart';
import 'package:app_pet_care/src/util/common_util.dart';
import 'package:app_pet_care/src/util/token_util.dart';
import 'package:get/get.dart';

class AppointmentServices extends GetConnect {
  AppointmentServices() {
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

  Future<Response> getAppointmentListDoctor(
      {int page = 0, int limit = 15, String? status}) async {
    Map<String, dynamic> query = {};
    query['doctorId'] = AccountUtil.getUserDoctorId();
    query['page'] = "$page";
    query['limit'] = "$limit";
    query['status'] = status;
    log(jsonEncode(query),
        name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await get('/appointments/appointments-list', query: query, headers: headers);
  }

  Future<Response> getAppointmentPetOwners() {
 final id = AccountUtil.getUserDoctorId();
    return get('/appointments/get-petowner/$id', headers: headers);
  }

  Future<Response> updateStatus({required String status, String? id}) async {
    Map<String, dynamic> body = {};
    body['status'] = status;
    log(jsonEncode(body),
        name: CommonUtil.getCurrentClassAndFuncName(StackTrace.current));
    return await put('/appointments/update-status/$id', body, headers: headers);
  }


}

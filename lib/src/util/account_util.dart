import 'package:jwt_decode/jwt_decode.dart';

import 'token_util.dart';

class AccountUtil {
  static Map<String, dynamic>? getTokenData() {
    var token = TokenUtil.getAccessToken();
    if (token == null) return null;
    return Jwt.parseJwt(TokenUtil.getAccessToken()!);
  }

  static Map<String, dynamic> getUser() {
    Map<String, dynamic> user = {};
    user["id"] = getUserId();
    user["fullName"] = getUserName();
    user["role"] = getUserRole();
    user["doctorId"] = getUserDoctorId();  
    return user;
  }

  static String getUserId() {
    final tokenData = getTokenData();
    if (tokenData != null) {
      return tokenData["id"];
    }
    return "";
  }

  static String getUserName() {
    final tokenData = getTokenData();
    if (tokenData != null) {
      return tokenData["fullName"];
    }
    return "";
  }

  static String getUserRole() {
    final tokenData = getTokenData();
    if (tokenData != null) {
      return tokenData["role"];
    }
    return "";
  }

  static String getUserDoctorId() {
    final tokenData = getTokenData();
    if (tokenData != null) {
      return tokenData["idDoctor"];
    }
    return "";
  }

  static bool isExpiredLogin() {
    final tokenData = getTokenData();
    if (tokenData != null) {
      return tokenData["exp"] < DateTime.now().millisecondsSinceEpoch / 1000;
    }
    return true;
  }
}

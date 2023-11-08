import 'package:hive/hive.dart';

import '../config/app_config.dart';

class TokenUtil {
  static final _storage = Hive.box(AppConfig.storageBox);

  static const String _accessTokenKey = "accessToken";
  static const String _refreshTokenKey = "refreshToken";

  static String? getAccessToken() {
    return _storage.get(_accessTokenKey);
  }

  static Future<void> setAccessToken(String value) async {
    await _storage.put(_accessTokenKey, value);
  }

  static String? getRefreshToken() {
    return _storage.get(_refreshTokenKey);
  }

  static Future<void> setRefreshToken(String value) async {
    await _storage.put(_refreshTokenKey, value);
  }
  

}

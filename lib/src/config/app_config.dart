import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AppConfig {
  static Locale get locale {
    return const Locale("vi");
  }

  /// fallback locale
  static const fallbackLocale = Locale('en');

  /// package name
  static const String packageName = "app_doctor_pet_care";

  /// storage box
  static const String storageBox = packageName;

  /// default transition
  static const Transition defaultTransition = Transition.fadeIn;

  /// initial route
  static String get initialRoute {
    return "/pet_care_notification";
  }

  static const Color materialMainBlueColor = Color(0xFF0072AD);
  static const String apiDomain = "http://192.168.1.6:8000/api";

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  
  static const bool autoLogin = true;
}

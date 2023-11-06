// ignore_for_file: unused_import
import 'package:app_pet_care/src/widget/home/home_dortor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';
import '../config/app_config.dart';
import '../config/app_theme_config.dart';
import '../util/get_page.dart';

class PetCareApp extends StatefulWidget {
  const PetCareApp({Key? key}) : super(key: key);

  @override
  State<PetCareApp> createState() => _PetCareAppState();
}

class _PetCareAppState extends State<PetCareApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeDoctor(),
        defaultTransition: AppConfig.defaultTransition,
        locale: AppConfig.locale,
        fallbackLocale: AppConfig.fallbackLocale,
        theme: AppThemeConfig.customTheme,
        getPages: GetPageCenter.pages,
        translationsKeys: Get.translations,
        supportedLocales: const [
          Locale('en', 'US'), // English
          Locale('vi', 'VN'),
        ],
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ]);
  }
}

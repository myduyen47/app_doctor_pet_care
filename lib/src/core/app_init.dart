import 'dart:developer';
import 'package:get_storage/get_storage.dart';

import '../config/app_config.dart';
import '../core/translation_init.dart';
import 'hive_init.dart';
import 'timezone_init.dart';

Future initApp() async {
  log("initialize application", name: AppConfig.packageName);
  await GetStorage.init();
  await initHive();
  await initAppTimezone();
  await initAppTranslation();
}

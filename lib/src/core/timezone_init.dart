import 'dart:developer' as dev;
import 'package:timezone/data/latest.dart' as tz;

import '../config/app_config.dart';

initAppTimezone() {
  tz.initializeTimeZones();
  dev.log('initialize timezone', name: AppConfig.packageName);
}

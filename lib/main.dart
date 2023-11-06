import 'dart:async';
import 'dart:developer';
import 'package:app_pet_care/firebase_options.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'src/config/app_config.dart';
import 'src/core/app_init.dart';
import 'src/widget/app.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

// Const
const String channelId = 'pet_care_channel';
const String channelName = 'Pet Care Channel Notifications';
const AndroidNotificationChannel channel = AndroidNotificationChannel(
  channelId,
  channelName,
  importance: Importance.high,
);
final notificationDetails = NotificationDetails(android: AndroidNotificationDetails(channel.id, channel.name));
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

void main() async {
  runZonedGuarded(() async {
    WidgetsFlutterBinding.ensureInitialized();
    await initApp();

    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    await FirebaseMessaging.instance.getToken();
    await FirebaseMessaging.instance.requestPermission();
    await FirebaseMessaging.instance.subscribeToTopic('all');
    // if (AccountUtil.getUserId().isNotEmpty) {
    //   await FirebaseMessaging.instance.subscribeToTopic(AccountUtil.getUserId());
    //   log('subscribed to topic: ${AccountUtil.getUserId()}', name: AppConfig.packageName);
    // }
    await _initializeLocalNotification();
    await _createNotificationChannel();
    _handleReceivedMessage();

    // FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    //
    // FirebaseMessaging.onBackgroundMessage((message) async {
    //   print("Handling a background message: ${message.messageId}");
    // });
    //
    // // foreground message
    // FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    //   print('Got a message whilst in the foreground!');
    //   print('Message data: ${message.data}');
    //
    //   if (message.notification != null) {
    //     print('Message also contained a notification: ${message.notification}');
    //     if (AppConfig.navigatorKey.currentContext != null) {
    //       ScaffoldMessenger.of(AppConfig.navigatorKey.currentContext!).showSnackBar(
    //         SnackBar(
    //           content: Text(message.notification!.body!),
    //           action: SnackBarAction(
    //             label: 'Close',
    //             onPressed: () {
    //               ScaffoldMessenger.of(AppConfig.navigatorKey.currentContext!).hideCurrentSnackBar();
    //             },
    //           ),
    //         ),
    //       );
    //     }
    //   }
    // });

    runApp(const PetCareApp());
  }, (Object error, StackTrace stack) {
    log(error.toString(), name: AppConfig.packageName);
  });
}

////////////////////////////////////////////////////////////////////////////////
// Init setting notification
////////////////////////////////////////////////////////////////////////////////

Future<void> _initializeLocalNotification() async {
  const initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
  const initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings);
}

Future<void> _createNotificationChannel() async {
  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(channel);
}

void _handleReceivedMessage() {
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  FirebaseMessaging.onMessage.listen(_firebaseMessagingForegroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen(_firebaseMessagingOpenedAppHandler);
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // await Future.delayed(const Duration(milliseconds: 150));
  await _showNotification(message);
}

Future<void> _firebaseMessagingForegroundHandler(RemoteMessage message) async {
  await _showNotification(message);
}

Future<void> _firebaseMessagingOpenedAppHandler(RemoteMessage message) async {
  log('A new onMessageOpenedApp event was published!', name: AppConfig.packageName);
  // _clickNotification(jsonEncode(message.data));
}

Future<void> _showNotification(RemoteMessage message) async {
  RemoteNotification? notification = message.notification;
  // await flutterLocalNotificationsPlugin.cancelAll();
  if (notification != null) {
    // await flutterLocalNotificationsPlugin.cancelAll();
    flutterLocalNotificationsPlugin.show(
      notification.hashCode,
      notification.title,
      notification.body,
      notificationDetails,
    );
  }
}

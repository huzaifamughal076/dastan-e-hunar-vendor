import 'dart:convert';

import 'package:dashtanehunar/Routes/names.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context) {
    InitializationSettings initializationSettings = InitializationSettings(
        android: const AndroidInitializationSettings("@mipmap/ic_launcher"),
        iOS: DarwinInitializationSettings());
    _notificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: (details) {
      if (details.payload != null) {
        handleOnTapNotificationEvent(context, details.payload!);
      }
    });
  }

  static Future<void> display(RemoteMessage message) async {
    try {
      final int id = DateTime.now().millisecondsSinceEpoch ~/ 1000;
      const NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
              "dastan-e-hunar-vendor", "Notification Channel",
              channelDescription: "This will contain all the updates",
              importance: Importance.max,
              playSound: true, 
              priority: Priority.high),
          iOS: DarwinNotificationDetails());

      await _notificationsPlugin.show(id, message.notification?.title,
          message.notification?.body, notificationDetails,
          payload: jsonEncode({
            "id": message.data["id"],
            "type": message.data["type"],
          }));
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }

  static handleOnTapNotificationEvent(BuildContext context, String data) {
    // Map notification = jsonDecode(data);
    // Navigator.pushNamed(context, AppRoutes.notificationPage);
    // Get.to(()=>const NotificationUI());
    Navigator.pushNamed(context, AppRoutes.notificationsScreen);
  }
}

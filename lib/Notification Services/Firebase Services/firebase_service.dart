import 'dart:async';
import 'dart:convert';

import 'package:dashtanehunar/Notification%20Services/Local%20Notifications/local_notification_service.dart';
import 'package:dashtanehunar/main.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';


class FirebaseNotificationService {
  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
  late StreamSubscription<RemoteMessage> messageSteam;
  late StreamSubscription<RemoteMessage> appOpeningSteam;
  late StreamSubscription<String> tokenSteam;
  Future<void> getPermissions() async {
    await Permission.notification.request().then((value) async => await firebaseMessaging.requestPermission(
                  alert: true,
                  announcement: false,
                  badge: true,
                  carPlay: false,
                  criticalAlert: false,
                  provisional: false,
                  sound: true,
                ));
  }

  handleTokenStatus(BuildContext context) async {
    if (kDebugMode) {
      print("Services Start Running");
      print(await firebaseMessaging.getToken());
    }
    tokenSteam = firebaseMessaging.onTokenRefresh.listen((event) async {
      debugPrint(event);
    });
  }

  


  void handleOnMessage() {
    messageSteam = FirebaseMessaging.onMessage.listen((message) {
      debugPrint("Messages");
      debugPrint(jsonEncode(message.data));
      if (message.notification != null) {
        LocalNotificationService.display(message);
      }
    });
  }

  void handleOnBackground() {
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  }

  Future<void> handleOnTapBackground(BuildContext context) async {
    await firebaseMessaging.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationService.handleOnTapNotificationEvent(
            context,
            jsonEncode({
              "id": message.data["id"],
              "type": message.data["type"],
            }));
      }
    });
  }

  void handleAppOpened(BuildContext context) {
    appOpeningSteam = FirebaseMessaging.onMessageOpenedApp.listen((message) {
      LocalNotificationService.handleOnTapNotificationEvent(
          context,
          jsonEncode({
            "id": message.data["id"],
            "type": message.data["type"],
          }));
    });
  }

  void dispose() {
    messageSteam.cancel();
    appOpeningSteam.cancel();
    tokenSteam.cancel();
  }
}

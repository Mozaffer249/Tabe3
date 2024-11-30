import 'dart:developer';
import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:get_storage/get_storage.dart';
import 'package:tabee3_flutter/app.dart';
import 'package:tabee3_flutter/app/data/common/common_variables.dart';

import 'package:timeago/timeago.dart' as timeago;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await GetStorage.init();
  await Firebase.initializeApp();
  await setupNotification();

  final langCode = CommonVariables.langCode.read(LANG_CODE) ?? "ar";

  timeago.setLocaleMessages(langCode, timeago.ArMessages());

  //! Set base url to development server
  CommonVariables.userData.write(BASE_URL, 'http://tabee-edu.com:10011/app_api');

  runApp(
    App(langCode: langCode),
  );
}

Future<void> _onBackgroundHandler(RemoteMessage message) async {
  log('On background message: ${message.data}');
  /* myLocalNotification(
    payload: message.data,
    title: message.notification!.title!,
    body: message.notification!.body!,
  ); */
}

Future<void> setupNotification() async {
  if (Platform.isIOS) {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}');
  }
  // FirebaseMessaging.instance.
  FirebaseMessaging.onMessage.listen(
    (RemoteMessage message) {
      /* myLocalNotification(
        payload: message.data,
        title: message.notification!.title!,
        body: message.notification!.body!,
      ); */
    },
  );
  FirebaseMessaging.onBackgroundMessage(_onBackgroundHandler);
  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) async {
    print('A new onMessageOpenedApp event was published! $message');
    // TODO: Implement on click on notification
  });
}

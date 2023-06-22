import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:app_vtr/login.dart';
import 'package:app_vtr/about/about.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<void> _firebaseMessagingBackgroundHandler (RemoteMessage message) async {
  await Firebase.initializeApp();
}


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  var token_is_defined = await data.getToken('token');

  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true
  );

  final fcmToken = await FirebaseMessaging.instance.getToken();

  await const FlutterSecureStorage().write(key: 'token_notificacao', value: fcmToken);

  if (token_is_defined != null && token_is_defined.isNotEmpty) {
    runApp(const About());
  } else {
    runApp(const Login());
  }
}

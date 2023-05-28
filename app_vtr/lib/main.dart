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
  print('TOKEN:  $fcmToken');
  await const FlutterSecureStorage().write(key: 'token_notificacao', value: fcmToken);

  1 < 3 ? runApp(const Login()) : runApp(const About());
}

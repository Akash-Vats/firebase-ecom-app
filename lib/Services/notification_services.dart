

import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';
Future<void> handleBackgroundMessage(RemoteMessage message)async{
log("--Title--${message.notification!.title}");
log("--Body--${message.notification!.body}");
log("--PAyload--${message.data}");
}
class NotificationServices{
  final messaging=FirebaseMessaging.instance;

  Future<void> initNotification()async{
 await messaging.requestPermission();
 final token= await messaging.getToken();
 print("----Token----> $token");
 FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
  }
}
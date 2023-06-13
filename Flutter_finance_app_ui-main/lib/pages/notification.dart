
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';
class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  Future initNotification() async{
    print("notf init");
    final AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsIOS =
        DarwinInitializationSettings(
      requestSoundPermission: true,
      requestBadgePermission: true,
      requestAlertPermission: true,
      onDidReceiveLocalNotification: (int id, String? title,String? body,String? payload) async {},
    );
    final InitializationSettings initializationSettings = InitializationSettings(
    android: initializationSettingsAndroid,
    iOS: initializationSettingsIOS,
  );
  await flutterLocalNotificationsPlugin.initialize(initializationSettings, onDidReceiveNotificationResponse: (NotificationResponse notificationresponse) async{});
  }
  notificationDetails(){
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'expenseNoti',
    'Expense Alert',
    playSound:  true,
    importance: Importance.high,
    priority: Priority.high,
  );
  const DarwinNotificationDetails iosPlatformChannelSpecifics =
      DarwinNotificationDetails(
        presentAlert: true,
    presentBadge: true,
    presentSound: true,
      );
  const NotificationDetails platformChannelSpecifics = NotificationDetails(
    android: androidPlatformChannelSpecifics,
    iOS: iosPlatformChannelSpecifics,
  );
  return platformChannelSpecifics;
  }

  Future showNotification() async {
  print("Showing notification");

  return flutterLocalNotificationsPlugin.show(
    0,
    'Expense Alert',
    'Watch out! Your spending is close to the limit!',
    notificationDetails(),
  );
}
  //Singleton pattern
  
  
    //instance of FlutterLocalNotificationsPlugin
}

class NotificationManagerSingleton {
  static final NotificationManagerSingleton _instance = NotificationManagerSingleton._internal();

  factory NotificationManagerSingleton() => _instance;

  NotificationManagerSingleton._internal();

  final NotificationService notificationManager = NotificationService();
}
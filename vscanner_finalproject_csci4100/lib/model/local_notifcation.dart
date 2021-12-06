import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter/material.dart';

// Notifies user on insert product status
// Based on the example given in class.
class DBNotification {
  BuildContext context;
  late FlutterLocalNotificationsPlugin notification;

  DBNotification(this.context) {
    initNotification();
  }

  //initialize notification
  initNotification() {
    notification = FlutterLocalNotificationsPlugin();
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings('@mipmap/vegescanner');
    IOSInitializationSettings iOSInitializationSettings =
        const IOSInitializationSettings();

    InitializationSettings initializationSettings = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    notification.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<String?> selectNotification(String? payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => const AlertDialog(
              title: Text("Product saved"),
              content: Text("Your product was saved successfully."),
            ));
  }

  Future showNotification(bool successOrFail) async {
    var android = AndroidNotificationDetails("channelId", "channelName",
        successOrFail ? "Save success" : "Save failed",
        priority: Priority.high, importance: Importance.max);
    var platformDetails = NotificationDetails(android: android);
    await notification.show(
        100,
        successOrFail ? "Save success" : "Save failed",
        successOrFail
            ? "Your product was saved!"
            : "Your product was not saved.",
        platformDetails,
        payload: "a demo payload");
  }
}

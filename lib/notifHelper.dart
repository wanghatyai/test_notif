import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotifHelper{
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  AndroidInitializationSettings androidInitializationSettings;
  IOSInitializationSettings iosInitializationSettings;
  InitializationSettings initializationSettings;

  NotifHelper(){
    initializedNotif();
  }

  initializedNotif() async{
    androidInitializationSettings = AndroidInitializationSettings('app_icon');
    iosInitializationSettings = IOSInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );
    initializationSettings = InitializationSettings(
      androidInitializationSettings, iosInitializationSettings);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future onDidReceiveLocalNotification(int id, String title, String body, String payload) async {
    await showDialog(
        context: context,
        builder: (BuildContext context) => CupertinoAlertDialog(
          title: Text(title),
          content: Text(body),
          actions: [
            CupertinoDialogAction(
              isDefaultAction: true,
              child: Text('Okayyy'),
              onPressed: (){

              },
            )
          ],
      )
    );
  }

  Future<void> showNotifBtweenInterval() async {
    try{
      var now = DateTime.now();
      var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

      SharedPreferences.getInstance().then((value) async {
        var a = value.getString('startTime');
        var b = value.getString('endTime');

        AndroidNotificationDetails androidNotificationDetails =
            AndroidNotificationDetails(
              'Channel_Id', 'Channel Name', 'Channel Description',
              importance: Importance.Max,
              priority: Priority.High,
              enableVibration: true,
              enableLights: true,
              ticker: 'test ticker',
              playSound: true,
            );

          IOSNotificationDetails iosNotificationDetails = IOSNotificationDetails();
          NotificationDetails notificationDetails = NotificationDetails(androidNotificationDetails, iosNotificationDetails);

          if(DateTime.parse(a).millisecondsSinceEpoch > currentTime.millisecondsSinceEpoch){
            print("current Time is less than startTime so, Cannot play notif");
            await flutterLocalNotificationsPlugin.cancel(0);
          }

          if(currentTime.millisecondsSinceEpoch >= DateTime.parse(a).millisecondsSinceEpoch
              && currentTime.millisecondsSinceEpoch <= DateTime.parse(b).millisecondsSinceEpoch){

              print("play notif");
              await flutterLocalNotificationsPlugin.show(0, "hello Notif", "test notif body", notificationDetails);
          }

          if(currentTime.millisecondsSinceEpoch > DateTime.parse(b).millisecondsSinceEpoch){
            print("current time is greater than end time so, can't pay notif");
            await flutterLocalNotificationsPlugin.cancel(0);
          }

      });
    }catch(_){
        print(_);
    }
  }

  notificationCompare(){
    var now = DateTime.now();
    var currentTime = DateTime(now.year, now.month, now.day, now.hour, now.minute);

    SharedPreferences.getInstance().then((value){
      var a = value.getString('startTime');
      var b = value.getString('endTime');

      String startHour = a.substring(11, 13);
      String endHour = a.substring(11, 13);

      var onlyCurrentDate = currentTime.toString().substring(0, 10);
      var onlyStartDate = a.toString().substring(0, 10);
      var onlyEndDate = a.toString().substring(0, 10);



    });
  }


}
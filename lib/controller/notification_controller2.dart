import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class NotificationManager2{

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  NotificationManager2() {


  }

  Future onSelectNotification(String payload) {
//    showDialog(
//        context: context,
//        builder: (_) =>
//            AlertDialog(
//              title: Text("ALERT"),
//              content: Text("CONTENT: $payload"),
//            ));
    print('Notification clicked');
    return Future.value(0);
  }

  showNotification(int hour,int min, int index) async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = new FlutterLocalNotificationsPlugin();
    var android = AndroidInitializationSettings('@mipmap/ic_launcher');
    var iOS = IOSInitializationSettings();
    var initSettings = InitializationSettings(android, iOS);
    flutterLocalNotificationsPlugin.initialize(initSettings,
        onSelectNotification: onSelectNotification);

    var time = Time(hour, min , 0);
    var androidPlatformChannelSpecifics =
    AndroidNotificationDetails('repeatDailyAtTime channel id',
        'repeatDailyAtTime channel name', 'repeatDailyAtTime description');
    var iOSPlatformChannelSpecifics =
    IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.showDailyAtTime(
        index,
        "wassup",
        'Daily notification shown at approximately ${time.hour}:${time
            .minute}:${time.second}',
        time,
        platformChannelSpecifics);
    print("DONE");
  }


}
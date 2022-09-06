import 'dart:async';

// import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

// class MyAwesomeNotificationServes {
//   static void init() {
//     AwesomeNotifications().initialize(
//       'resource://drawable/ic_launcher',
//       [
//         NotificationChannel(
//           channelKey: 'basic_channel',
//           channelName: 'Basic Notifications',
//           defaultColor: Colors.teal,
//           importance: NotificationImportance.High,
//           channelShowBadge: true,
//           channelDescription: '',
//           enableLights: true,
//         ),
//         NotificationChannel(
//           channelKey: 'scheduled_channel',
//           channelName: 'Scheduled Notifications',
//           defaultColor: Colors.teal,
//           locked: true,
//           importance: NotificationImportance.High,
//           channelDescription: '',
//           enableLights: true,
//         ),
//       ],
//     );
//   }

//   static pushNotification() async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 1,
//         channelKey: 'basic_channel',
//         title: 'Buy Plant Food!!!',
//         body: 'Florist at 123 Main St. has 2 in stock',
//         color: Colors.red,
//       ),
//     );
//   }

//   static Future<void> scheduledNotification() async {
//     await AwesomeNotifications().createNotification(
//       content: NotificationContent(
//         id: 2,
//         channelKey: 'scheduled_channel',
//         title: '${Emojis.wheater_droplet} Add some water to your plant!',
//         body: 'Water your plant regularly to keep it healthy.',
//         notificationLayout: NotificationLayout.Default,
//         wakeUpScreen: true,
//       ),
//       actionButtons: [
//         NotificationActionButton(
//           key: 'MARK_DONE',
//           label: 'Mark Done',
//         ),
//       ],
//       schedule: NotificationCalendar(
//         hour: DateTime.now().hour,
//         minute: DateTime.now().minute + 1,
//         second: 0,
//         millisecond: 0,
//         repeats: true,
//       ),
//     );
//   }

//   Future<void> cancelScheduledNotifications() async {
//     await AwesomeNotifications().cancelAllSchedules();
//   }
// }

class NotificationServes {
  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("ic_launcher");
    InitializationSettings initializationSettings =
        const InitializationSettings(android: androidSettings);

    await _localNotification.initialize(initializationSettings);
  }

  static void pushNotification(int id) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await _localNotification.show(
      id,
      'Tis is title$id',
      'This is body',
      notificationDetails,
    );
  }

  static void repetedNotification(int id, DateTime finish) async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      enableVibration: false,
      fullScreenIntent: false,
      enableLights: true,
    );

    NotificationDetails notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    Timer.periodic(
      const Duration(seconds: 1),
      (timer) async {
        final now = DateTime.now();
        await _localNotification.show(
          id,
          'Tis is title$id',
          '${now.hour}:${now.minute}:${now.second}',
          notificationDetails,
        );
        if (now.isAfter(finish.add(const Duration(seconds: 1)))) {
          timer.cancel();
        }
      },
    );
  }

  // static void onTap() async {
  //   for (var k = 0; k < 10; k++) {
  //     var msg = "Downloading...";
  //     if (k == 9) {
  //       msg = "Completed";
  //     }
  //     await Future.delayed(
  //       const Duration(seconds: 1),
  //       () async {
  //         var androidPlatformChannelSpecifics = AndroidNotificationDetails(
  //           'channelId',
  //           'channelName',
  //           importance: Importance.low,
  //           priority: Priority.low,
  //           showProgress: true,
  //           progress: (k + 1) * 20,
  //           autoCancel: false,
  //           maxProgress: 100,
  //           color: Colors.pink,
  //         );
  //         NotificationDetails notificationDetails = NotificationDetails(
  //           android: androidPlatformChannelSpecifics,
  //         );
  //         await _localNotification.show(
  //           0,
  //           'rrtutors',
  //           msg,
  //           notificationDetails,
  //         );
  //       },
  //     );
  //   }
  // }
}


/*
  static void scheduledNotification() async {
    final date1 = DateTime.parse('2022-08-07 17:37:00');
    final date2 = DateTime.parse('2022-08-07 12:00:00');
    print(DateTime.now().difference(date1).inMinutes);
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Detroit'));
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'channelId',
      'channelName',
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);

    await _localNotification.zonedSchedule(
      0,
      'scheduled title',
      'scheduled body',
      tz.TZDateTime.now(tz.local).add(date1.difference(DateTime.now())),
      notificationDetails,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }
*/



import 'dart:async';

import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServes {
  static final FlutterLocalNotificationsPlugin _localNotification =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    const AndroidInitializationSettings androidSettings =
        AndroidInitializationSettings("ic_launcher");

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: androidSettings,
    );

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

// void selectNotification(String payload) async {
//     if (payload != null) {
//       debugPrint('notification payload: $payload');
//     }
//     await Navigator.push(
//       context,
//       MaterialPageRoute<void>(builder: (context) => SecondScreen(payload)),
//     );
// }

  static void scheduledNewTask({
    required TaskModel task,
  }) async {
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Africa/Cairo'));
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails(
      'TasksDeadline',
      'Tasks Deadline',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
    );
    NotificationDetails notificationDetails =
        NotificationDetails(android: androidNotificationDetails);
    final deadlineNotificationsTimes =
        _getDeadlineDuration(task.deadline.toDate());

    for (var time in deadlineNotificationsTimes) {
      _localNotification.zonedSchedule(
        _getNotificationId(task.taskId!),
        task.taskName,
        'Be careful you didn\'t finish your task',
        tz.TZDateTime.now(tz.local).add(time),
        notificationDetails,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime,
      );
    }
  }

  static int _getNotificationId(String taskId) {
    int notificationId = 1;
    final RegExp exp = RegExp(r'(\d+)');
    final matches = exp.allMatches(taskId);
    for (var match in matches) {
      final int digit = int.parse(match.group(0)!);
      if (digit < 6) {
        notificationId += digit;
      } else {
        notificationId *= digit;
      }
    }
    return notificationId;
  }

  static List<Duration> _getDeadlineDuration(DateTime deadline) {
    final List<Duration> taskNotificationsTimes = [];
    Duration deadlineDuration = deadline.difference(DateTime.now());
    taskNotificationsTimes.add(deadlineDuration);
    if (deadlineDuration.inDays != 0) {
      taskNotificationsTimes.add(deadline
          .subtract(const Duration(days: 1))
          .difference(DateTime.now()));
    }
    return taskNotificationsTimes;
  }

  static void test() {}
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

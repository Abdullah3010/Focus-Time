import 'package:flutter/material.dart';
import 'package:focus_time/config/notifications/app_notification.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';

// class TestScreen extends StatelessWidget {
//   const TestScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     NotificationServes.init();

//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//         child: RoundedButton(
//           child: Text('sdf'),
//           onPressed: () {
//             // NotificationServes.getNotificationId('sdf5s3d8s35dfs4df');
//           },
//         ),
//       ),
//     );
//   }
// }

class TestScreen extends StatelessWidget {

  final Function() function;


  const TestScreen({super.key, required this.function});

  @override
  Widget build(BuildContext context) {
    NotificationServes.init();

    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: MaterialButton(
          onPressed: () {
            function();
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = CurrentUser.get();
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            CircleAvatar(
              radius: 100,
              // backgroundImage: ExactAssetImage('assets/imageBG.jpeg'),
              child: ClipOval(
                child: Image.asset(
                  'assets/imageBG.jpeg',
                  fit: BoxFit.fill,
                  width: 200.0,
                  height: 200.0,
                ),
              ),
            ),
            Text("${user!.firstName} ${user.lastName}"),
            Container(
              width: double.infinity,
              
              color: AppColors.primary,
              child: Column(
                children: [
                  Text(user.email),
                  Text(user.phone),
                  Text(user.birthdate.toString()),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

class GroupSettingsScreen extends StatelessWidget {
  final UserModel owner;

  const GroupSettingsScreen({super.key, required this.owner});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Center(
        child: Column(
          children: [
            Text(owner.email),
          ],
        ),
      ),
    );
  }
}

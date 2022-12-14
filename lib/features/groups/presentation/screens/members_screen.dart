import 'package:flutter/material.dart';

class MembersScreen extends StatelessWidget {
  final List<String> members;

  const MembersScreen({super.key, required this.members});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Members'),
      ),
      body: Center(
        child: Column(
          children: [
            ...members.map((e) => Text(e)),
          ],
        ),
      ),
    );
  }
}

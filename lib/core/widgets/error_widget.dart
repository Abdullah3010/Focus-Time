import 'package:flutter/material.dart';

class MyErrorWidget extends StatelessWidget {
  final String errorMessage;

  const MyErrorWidget({required this.errorMessage});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        errorMessage,
        style: const TextStyle(
          fontSize: 40,
        ),
      ),
    );
  }
}

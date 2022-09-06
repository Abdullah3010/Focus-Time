import 'package:flutter/material.dart';
import 'package:focus_time/features/auth/presentation/widgets/sign_in_form.dart';

class SignInScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: SingleChildScrollView(
          child: SignInForm(),
        ),
      ),
    );
  }
}

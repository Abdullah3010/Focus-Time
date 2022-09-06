import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:focus_time/features/auth/presentation/screens/sign_screen.dart';
import 'package:focus_time/core/widgets/input_field.dart';
import 'package:focus_time/features/auth/presentation/widgets/social_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthErrorState) {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text(
                'Error',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
              content: Text(
                state.errorMessage,
              ),
              actionsAlignment: MainAxisAlignment.center,
              actions: [
                RoundedButton(
                  child: const Text(
                    'OK',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthBloc>(context);
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                controller: emailControler,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email can't be empty";
                  }
                  return null;
                },
              ),
              InputField(
                controller: passwordControler,
                label: 'Password',
                obscureText: bloc.isPassword,
                keyboardType: TextInputType.visiblePassword,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can't be empty";
                  }
                  return null;
                },
                prefixIcon: const Icon(
                  Icons.lock,
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    bloc.isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    bloc.add(ChangePasswordVisibilityEvent());
                  },
                ),
              ),
              RoundedButton(
                child: const Text(
                  "login",
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    bloc.add(
                      LoginEvent(
                        email: emailControler.text,
                        password: passwordControler.text,
                      ),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I don\'t have account',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      bloc.isPassword = true;
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SignInScreen()),
                      );
                    },
                    child: const Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  SizedBox(
                    width: 100,
                    child: Divider(
                      endIndent: 10,
                      thickness: 2,
                      color: Colors.black12,
                    ),
                  ),
                  Text(
                    'OR',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  SizedBox(
                    width: 100,
                    child: Divider(
                      indent: 10,
                      thickness: 2,
                      color: Colors.black12,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SocialIcon(
                    icon: FontAwesomeIcons.facebook,
                    color: const Color(0xff035397),
                    onPressed: () {
                    },
                  ),
                  const SizedBox(
                    width: 20,
                    height: 70,
                  ),
                  SocialIcon(
                    icon: FontAwesomeIcons.googlePlus,
                    color: const Color(0xffF90716),
                    onPressed: () {
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:focus_time/features/home/presentation/screens/home_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/my_date_picker.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/auth/presentation/bloc/auth_bloc/auth_bloc.dart';
import 'package:focus_time/features/auth/presentation/screens/login_screen.dart';
import 'package:focus_time/core/widgets/input_field.dart';
import 'package:focus_time/features/auth/presentation/widgets/social_icon.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignInForm extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController birthdateControler = TextEditingController();
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
        } else if (state is AuthSignInSuccessState) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
          );
        }
      },
      builder: (context, state) {
        final bloc = BlocProvider.of<AuthBloc>(context);
        if (state is PickDateState) {
          birthdateControler.text = state.date;
          bloc.add(ReturnToInitialEvent());
        }
        return Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InputField(
                controller: nameControler,
                label: 'Name',
                keyboardType: TextInputType.name,
                prefixIcon: const Icon(Icons.person),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email can't be empty";
                  }
                  return null;
                },
              ),
              InputField(
                controller: emailControler,
                label: 'Email',
                keyboardType: TextInputType.emailAddress,
                prefixIcon: const Icon(Icons.email),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can't be empty";
                  }
                  return null;
                },
              ),
              InputField(
                controller: phoneControler,
                label: 'phone',
                keyboardType: TextInputType.phone,
                prefixIcon: const Icon(Icons.phone),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email can't be empty";
                  }
                  return null;
                },
              ),
              InputField(
                controller: birthdateControler,
                label: 'birthdate',
                keyboardType: TextInputType.datetime,
                prefixIcon: const Icon(Icons.cake),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () => _pickBirthdate(bloc, context),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Password can't be empty";
                  }
                  return null;
                },
              ),
              InputField(
                controller: passwordControler,
                label: 'Password',
                keyboardType: TextInputType.visiblePassword,
                obscureText: bloc.isPassword,
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  icon: Icon(
                    bloc.isPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  padding: const EdgeInsets.only(right: 15),
                  onPressed: () {
                    bloc.add(ChangePasswordVisibilityEvent());
                  },
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Email can't be empty";
                  }
                  return null;
                },
              ),
              RoundedButton(
                text: 'Sign Up',
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    final firstAndLastName = _getFirstAndLastName(
                      nameControler.text,
                    );
                    final birthdate = Timestamp.fromDate(
                      DateTime.parse(birthdateControler.text),
                    );
                    UserModel user = UserModel(
                      firstName: firstAndLastName[0],
                      lastName: firstAndLastName[1],
                      email: emailControler.text,
                      password: passwordControler.text,
                      phone: phoneControler.text,
                      birthdate: birthdate,
                      gender: 'Male',
                      avaterPath: 'test',
                    );
                    bloc.add(
                      SignInEvent(user: user),
                    );
                  }
                },
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'I already have account',
                    style: TextStyle(
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      bloc.isPassword = true;
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: const Text(
                      'Login',
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
                    onPressed: () {},
                  ),
                  const SizedBox(
                    width: 20,
                    height: 70,
                  ),
                  SocialIcon(
                    icon: FontAwesomeIcons.googlePlus,
                    color: const Color(0xffF90716),
                    onPressed: () {},
                  ),
                ],
              ),
            ],
          ),
        );
      
      },
    );
  }

  List<String> _getFirstAndLastName(String name) {
    return name.split(' ')..add('');
  }

  void _pickBirthdate(AuthBloc bloc, BuildContext context) {
    final myPicker = MyDateTimePicker(
      context: context,
      title: 'Birthdate',
    );
    var formatter = DateFormat('yyyy-MM-dd');
    myPicker.getDate().then(
        (value) => bloc.add(PickDateEvent(date: formatter.format(value))));
  }
}

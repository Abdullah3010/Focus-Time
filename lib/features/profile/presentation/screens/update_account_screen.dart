import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/config/api/sqflite_api.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/widgets/input_field.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/profile/presentation/bloc/profile_bloc/profile_bloc.dart';

class UpdateAccountScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  final TextEditingController nameControler = TextEditingController();
  final TextEditingController emailControler = TextEditingController();
  final TextEditingController phoneControler = TextEditingController();
  final TextEditingController birthdateControler = TextEditingController();
  final TextEditingController passwordControler = TextEditingController();

  UpdateAccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final currentUser = CurrentUser.get();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Account'),
      ),
      body: BlocBuilder<ProfileBloc, ProfileState>(
        builder: (context, state) {
          final bloc = BlocProvider.of<ProfileBloc>(context);

          return Center(
            child: RoundedButton(
              text: 'Update',
              onPressed: () {
                UserModel user = UserModel(
                  userId: currentUser!.userId,
                  firstName: 'Abdullah',
                  lastName: 'Mohamed',
                  email: currentUser.email,
                  password: '123456',
                  phone: '01100800500',
                  birthdate: Timestamp.now(),
                  gender: 'Male',
                  avaterPath: 'test',
                );
                bloc.add(UpdateUserEvent(user: user));
              },
            ),
          );
        },
      ),
    );
  }

  // Center testtest(BuildContext context) {
  //   return Center(
  //     child: Form(
  //       key: formKey,
  //       child: Column(
  //         mainAxisAlignment: MainAxisAlignment.center,
  //         children: [
  //           InputField(
  //             controller: nameControler,
  //             label: 'Name',
  //             keyboardType: TextInputType.name,
  //             prefixIcon: const Icon(Icons.person),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "Email can't be empty";
  //               }
  //               return null;
  //             },
  //           ),
  //           InputField(
  //             controller: emailControler,
  //             label: 'Email',
  //             keyboardType: TextInputType.emailAddress,
  //             prefixIcon: const Icon(Icons.email),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "Password can't be empty";
  //               }
  //               return null;
  //             },
  //           ),
  //           InputField(
  //             controller: phoneControler,
  //             label: 'phone',
  //             keyboardType: TextInputType.phone,
  //             prefixIcon: const Icon(Icons.phone),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "Email can't be empty";
  //               }
  //               return null;
  //             },
  //           ),
  //           InputField(
  //             controller: birthdateControler,
  //             label: 'birthdate',
  //             keyboardType: TextInputType.datetime,
  //             prefixIcon: const Icon(Icons.cake),
  //             suffixIcon: IconButton(
  //               icon: const Icon(Icons.calendar_month),
  //               padding: const EdgeInsets.only(right: 15),
  //               onPressed: () => _pickBirthdate(bloc, context),
  //             ),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "Password can't be empty";
  //               }
  //               return null;
  //             },
  //           ),
  //           InputField(
  //             controller: passwordControler,
  //             label: 'Password',
  //             keyboardType: TextInputType.visiblePassword,
  //             obscureText: bloc.isPassword,
  //             prefixIcon: const Icon(Icons.lock),
  //             suffixIcon: IconButton(
  //               icon: Icon(
  //                 bloc.isPassword ? Icons.visibility : Icons.visibility_off,
  //               ),
  //               padding: const EdgeInsets.only(right: 15),
  //               onPressed: () {
  //                 bloc.add(ChangePasswordVisibilityEvent());
  //               },
  //             ),
  //             validator: (value) {
  //               if (value!.isEmpty) {
  //                 return "Email can't be empty";
  //               }
  //               return null;
  //             },
  //           ),
  //           RoundedButton(
  //             child: const Text(
  //               "Sign In",
  //               style: TextStyle(
  //                 fontSize: 20,
  //               ),
  //             ),
  //             onPressed: () async {
  //               if (formKey.currentState!.validate()) {
  //                 final firstAndLastName = _getFirstAndLastName(
  //                   nameControler.text,
  //                 );
  //                 final birthdate = Timestamp.fromDate(
  //                   DateTime.parse(birthdateControler.text),
  //                 );
  //                 UserModel user = UserModel(
  //                   firstName: firstAndLastName[0],
  //                   lastName: firstAndLastName[1],
  //                   email: emailControler.text,
  //                   password: passwordControler.text,
  //                   phone: phoneControler.text,
  //                   birthdate: birthdate,
  //                   gender: 'Male',
  //                   avaterPath: 'test',
  //                 );
  //                 bloc.add(
  //                   SignInEvent(user: user),
  //                 );
  //               }
  //             },
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               const Text(
  //                 'I already have account',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w300,
  //                 ),
  //               ),
  //               TextButton(
  //                 onPressed: () {
  //                   bloc.isPassword = true;
  //                   Navigator.pushReplacement(
  //                     context,
  //                     MaterialPageRoute(builder: (context) => LoginScreen()),
  //                   );
  //                 },
  //                 child: const Text(
  //                   'Login',
  //                   style: TextStyle(
  //                     color: Colors.blue,
  //                   ),
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: const [
  //               SizedBox(
  //                 width: 100,
  //                 child: Divider(
  //                   endIndent: 10,
  //                   thickness: 2,
  //                   color: Colors.black12,
  //                 ),
  //               ),
  //               Text(
  //                 'OR',
  //                 style: TextStyle(
  //                   fontWeight: FontWeight.w300,
  //                 ),
  //               ),
  //               SizedBox(
  //                 width: 100,
  //                 child: Divider(
  //                   indent: 10,
  //                   thickness: 2,
  //                   color: Colors.black12,
  //                 ),
  //               ),
  //             ],
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: [
  //               SocialIcon(
  //                 icon: FontAwesomeIcons.facebook,
  //                 color: const Color(0xff035397),
  //                 onPressed: () {},
  //               ),
  //               const SizedBox(
  //                 width: 20,
  //                 height: 70,
  //               ),
  //               SocialIcon(
  //                 icon: FontAwesomeIcons.googlePlus,
  //                 color: const Color(0xffF90716),
  //                 onPressed: () {},
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}

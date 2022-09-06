import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserAuth extends Equatable {
  String? userId;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String phone;
  final Timestamp birthdate;
  final String gender;
  final String avaterPath;

  UserAuth({
    this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
    required this.phone,
    required this.birthdate,
    required this.gender,
    required this.avaterPath,
  });

  @override
  List<Object?> get props => [
        userId,
        firstName,
        lastName,
        email,
        password,
        phone,
        birthdate,
        gender,
        avaterPath,
      ];
}

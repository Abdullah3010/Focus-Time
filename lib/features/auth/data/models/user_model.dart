import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_time/features/auth/domain/entities/user_auth.dart';

class UserModel extends UserAuth {
  UserModel({
    super.userId,
    required super.firstName,
    required super.lastName,
    required super.email,
    required super.password,
    required super.phone,
    required super.birthdate,
    required super.gender,
    required super.avaterPath,
  });

  factory UserModel.fromUserAuth(UserAuth user) {
    return UserModel(
      userId: user.userId,
      firstName: user.firstName,
      lastName: user.lastName,
      email: user.email,
      password: user.password,
      phone: user.phone,
      birthdate: user.birthdate,
      gender: user.gender,
      avaterPath: user.avaterPath,
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json['userId'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      birthdate: json['birthdate'],
      gender: json['gender'],
      avaterPath: json['avaterPath'],
    );
  }

  factory UserModel.fromDatabase(Map<String, dynamic> database) {
    return UserModel(
      userId: database['userId'],
      firstName: database['firstName'],
      lastName: database['lastName'],
      email: database['email'],
      password: database['password'],
      phone: database['phone'],
      birthdate: Timestamp.fromDate(DateTime.parse(database['birthdate'])),
      gender: database['gender'],
      avaterPath: database['avaterPath'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'birthdate': birthdate,
      'gender': gender,
      'avaterPath': avaterPath,
    };
  }

  Map<String, dynamic> toDatabase() {
    return {
      'userId': userId,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'phone': phone,
      'birthdate': birthdate.toDate().toString(),
      'gender': gender,
      'avaterPath': avaterPath,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/config/api/sqflite_api.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

abstract class ProfileLocalDataSource {
  Future<Unit> updateProfile(UserModel user);
}

class ProfileLocalWithSqflite extends ProfileLocalDataSource {
  ProfileLocalWithSqflite();

  @override
  Future<Unit> updateProfile(UserModel user) {
    try {
      MySqfliteAPI.updateUser(user);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}

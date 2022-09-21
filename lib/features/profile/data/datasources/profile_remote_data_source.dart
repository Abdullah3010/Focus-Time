import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

abstract class ProfileRemoteDataSource {
  Future<Unit> updateProfile(UserModel data);
}

class ProfileRemoteWithFirebase extends ProfileRemoteDataSource {
  final FirebaseFirestore firestore;

  ProfileRemoteWithFirebase({required this.firestore});

  @override
  Future<Unit> updateProfile(UserModel user) {
    try {
      firestore.collection('users').doc(user.userId).update(user.toJson());
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_time/core/errors/errors_exceptions.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

abstract class AuthRemoteDateSource {
  Future<UserModel> login({
    required String email,
    required String password,
  });
  Future<UserModel> signIn({required UserModel user});
  Future<Unit> logout();
}

class AuthRemoteImpWithFirebase extends AuthRemoteDateSource {
  final FirebaseAuth auth;
  final FirebaseFirestore firestore;

  AuthRemoteImpWithFirebase({
    required this.firestore,
    required this.auth,
  });

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firestoreUser = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();
      final user = firestoreUser.data();
      return UserModel.fromJson(user!);
    } on FirebaseAuthException catch (e) {
      throw _getLoginError(e.code);
    } catch (e) {
      //TODO Null Check operatore exception in return statment
      throw ServerException();
    }
  }

  @override
  Future<Unit> logout() async {
    try {
      await auth.signOut();
      return Future.value(unit);
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<UserModel> signIn({required UserModel user}) async {
    try {
      final userCredential = await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );
      user.userId = userCredential.user!.uid;
      _saveUserData(user);
      return user;
    } on FirebaseAuthException catch (e) {
      throw _getSignInError(e.code);
    } catch (e) {
      throw ServerException();
    }
  }

  Future<void> _saveUserData(UserModel user) async {
    try {
      await firestore.collection('users').doc(user.userId).set(user.toJson());
    } catch (e) {
      throw ServerException();
    }
  }

  Exception _getLoginError(String errorCode) {
    if (errorCode == 'user-not-found') {
      return AuthUserNotFountException();
    } else if (errorCode == 'wrong-password') {
      return AuthWrongPasswordException();
    } else if (errorCode == 'invalid-email') {
      return AuthInvalidEmailException();
    }
    return UnexpectedException();
  }

  Exception _getSignInError(String errorCode) {
    if (errorCode == 'email-already-in-use') {
      return AuthAlreadyExistException();
    } else if (errorCode == 'weak-password') {
      return AuthWeakPasswordException();
    } else if (errorCode == 'invalid-email') {
      return AuthInvalidEmailException();
    }
    return UnexpectedException();
  }
}

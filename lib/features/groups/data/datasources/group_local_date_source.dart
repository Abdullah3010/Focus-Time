import 'package:dartz/dartz.dart';
import 'package:focus_time/config/api/sqflite_api.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

abstract class AuthLocalDateSource {
  Future<Unit> localSignIn({required UserModel user});
  Future<UserModel> getUser({required String id});
  Future<Unit> localLogout();
  Future<UserModel> localLogin({
    required String email,
    required String password,
  });
}

class AuthLocalImpWithSqflite extends AuthLocalDateSource {
  @override
  Future<UserModel> getUser({required String id}) async {
    final user = await MySqfliteAPI.getUser(id);
    return UserModel.fromDatabase(user);
  }

  @override
  Future<Unit> localSignIn({required UserModel user}) async {
    try {
      await MySqfliteAPI.localSignIn(user);
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> localLogin({
    required String email,
    required String password,
  }) async {
    try {
      return await MySqfliteAPI.localLogin(
        email: email,
        password: password,
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> localLogout() async {
    try {
      await MySqfliteAPI.localLogOut();
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}

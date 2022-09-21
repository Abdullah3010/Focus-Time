import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

abstract class ProfileRepository {
  Future<Either<Failure, Unit>> updateUser(UserModel user);
}
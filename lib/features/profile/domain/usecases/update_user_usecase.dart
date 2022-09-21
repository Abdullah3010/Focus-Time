import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/profile/domain/repositories/profile_repository.dart';

class UpdateUserUseCase {
  final ProfileRepository repository;

  UpdateUserUseCase(this.repository);

  Future<Either<Failure, Unit>> call(UserModel user) async {
    return await repository.updateUser(user);
  }
}
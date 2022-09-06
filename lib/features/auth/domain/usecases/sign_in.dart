import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/auth/domain/repositories/auth_repository.dart';

class SignInUsecase {
  final AuthRepository authRepository;

  SignInUsecase(this.authRepository);

  Future<Either<Failure, UserModel>> call(UserModel user) async {
    return await authRepository.signIn(user);
  }
}

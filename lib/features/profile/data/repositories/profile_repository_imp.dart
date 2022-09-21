import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/profile/data/datasources/profile_local_date_source.dart';
import 'package:focus_time/features/profile/data/datasources/profile_remote_data_source.dart';
import 'package:focus_time/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImp implements ProfileRepository {
  final ProfileRemoteDataSource remoteDataSource;
  final ProfileLocalDataSource localDataSource;

  ProfileRepositoryImp({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, Unit>> updateUser(UserModel user) {
    try {
      remoteDataSource.updateProfile(user);
      localDataSource.updateProfile(user);
      CurrentUser.set(user);
      return Future.value(const Right(unit));
    } catch (e) {
      return Future.value(Left(ServerFailure()));
    }
  }
}

import 'package:focus_time/config/api/sqflite_api.dart';
import 'package:focus_time/core/errors/errors_exceptions.dart';
import 'package:focus_time/features/auth/data/datasources/auth_local_date_source.dart';
import 'package:focus_time/features/auth/data/datasources/auth_remote_date_source.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/features/auth/domain/repositories/auth_repository.dart';
import 'package:focus_time/core/network/network_info.dart';

class AuthRepositoryImp extends AuthRepository {
  final AuthRemoteDateSource authRemoteDateSource;
  final AuthLocalDateSource authLocalDateSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImp({
    required this.authRemoteDateSource,
    required this.authLocalDateSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserModel>> login({
    required String email,
    required String password,
  }) async {
    late UserModel user;
    if (await networkInfo.isConnected) {
      try {
        user = await authRemoteDateSource.login(
          email: email,
          password: password,
        );
        MySqfliteAPI.saveCurrentUser(user);
        return Right(user);
      } on Exception catch (e) {
        return Left(_getLoginFailure(e));
      }
    } else {
      try {
        user = await authLocalDateSource.localLogin(
          email: email,
          password: password,
        );
        return Right(user);
      } on Exception catch (e) {
        return Left(_getLocalLoginFailure(e));
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {
    try {
      await authRemoteDateSource.logout();
      await authLocalDateSource.localLogout();
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, UserModel>> signIn(UserModel user) async {
    late UserModel signedUser;
    try {
      signedUser = await authRemoteDateSource.signIn(user: user);
    } on Exception catch (e) {
      return Left(_getSignInFailure(e));
    }
    try {
      await authLocalDateSource.localSignIn(user: signedUser);
    } on Exception catch (e) {
      return Left(_getLocalSignInFailure(e));
    }
    return Right(signedUser);
  }

  Failure _getLoginFailure(Exception exception) {
    if (exception is AuthUserNotFountException) {
      return AuthUserNotFountFailure();
    } else if (exception is AuthWrongPasswordException) {
      return AuthWrongPasswordFailure();
    } else if (exception is AuthInvalidEmailException) {
      return AuthInvalidEmailFailure();
    } else if (exception is ServerException) {
      return ServerFailure();
    }
    return UnexpectedFailure();
  }

  Failure _getLocalLoginFailure(Exception exception) {
    if (exception is AuthLocalUserNotFountException) {
      return AuthLocalUserNotFountFailure();
    } else if (exception is UnexpectedDatabaseException) {
      return UnexpectedDatabaseFailure();
    } else if (exception is ServerException) {
      return ServerFailure();
    }
    return UnexpectedFailure();
  }

  Failure _getSignInFailure(Exception exception) {
    if (exception is AuthAlreadyExistException) {
      return AuthAlreadyExistFailure();
    } else if (exception is AuthWeakPasswordException) {
      return AuthWeakPasswordFailure();
    } else if (exception is AuthInvalidEmailException) {
      return AuthInvalidEmailFailure();
    } else if (exception is ServerException) {
      return ServerFailure();
    }
    return UnexpectedFailure();
  }

  Failure _getLocalSignInFailure(Exception exception) {
    if (exception is InsertingExistsUserException) {
      return InsertingExistsUserFailure();
    } else if (exception is InsertingNullException) {
      return InsertingNullFailure();
    } else if (exception is UnexpectedDatabaseException) {
      return UnexpectedDatabaseFailure();
    } else if (exception is ServerException) {
      return ServerFailure();
    }
    return UnexpectedFailure();
  }
}

import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {}

class OfflineFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class ServerFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class EmptyCacheFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnexpectedFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class UnexpectedDatabaseFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthInvalidEmailFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthAlreadyExistFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthWeakPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthUserNotFountFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthWrongPasswordFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InsertingNullFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class InsertingExistsUserFailure extends Failure {
  @override
  List<Object?> get props => [];
}

class AuthLocalUserNotFountFailure extends Failure {
  @override
  List<Object?> get props => [];
}

part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginEvent({
    required this.email,
    required this.password,
  });

  @override
  List<Object> get props => [email, password];
}

class SignInEvent extends AuthEvent {
  final UserModel user;

  const SignInEvent({required this.user});

  @override
  List<Object> get props => [user];
}

class LogOutEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class ChangePasswordVisibilityEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class ReturnToInitialEvent extends AuthEvent {
  @override
  List<Object> get props => [];
}

class PickDateEvent extends AuthEvent {
  final String date;

  const PickDateEvent({required this.date});

  @override
  List<Object> get props => [date];
}

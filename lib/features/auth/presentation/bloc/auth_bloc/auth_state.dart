part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLodingState extends AuthState {}

class AuthErrorState extends AuthState {
  final String errorMessage;

  const AuthErrorState({required this.errorMessage});
}

class AuthLoginSuccessState extends AuthState {
  final UserModel user;

  const AuthLoginSuccessState({required this.user});
}

class AuthSignInSuccessState extends AuthState {
  final UserModel user;

  const AuthSignInSuccessState({required this.user});
}

class AuthLogoutSuccessState extends AuthState {}

class PickDateState extends AuthState {
  final String date;

  const PickDateState({required this.date});
}

class ChangePasswordVisibilityOnState extends AuthState {}

class ChangePasswordVisibilityOffState extends AuthState {}

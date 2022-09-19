import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/core/strings/failure_messages.dart';
import 'package:focus_time/core/strings/firebase_messages.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/auth/domain/usecases/login.dart';
import 'package:focus_time/features/auth/domain/usecases/logout.dart';
import 'package:focus_time/features/auth/domain/usecases/sign_in.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase loginUsecase;
  final SignInUsecase signInUsecase;
  final LogoutUsecase logoutUsecase;

  bool isPassword = true;

  AuthBloc({
    required this.loginUsecase,
    required this.logoutUsecase,
    required this.signInUsecase,
  }) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is LoginEvent) {
        emit(AuthLodingState());
        final loginResponse = await loginUsecase(
          email: event.email,
          password: event.password,
        );
        loginResponse.fold(
          (failure) => emit(
            AuthErrorState(
              errorMessage: _getLoginFailureMessage(failure),
            ),
          ),
          (user) {
            CurrentUser.set(user);
            emit(AuthLoginSuccessState(user: user));
          },
        );
      } else if (event is SignInEvent) {
        emit(AuthLodingState());
        final loginResponse = await signInUsecase(event.user);
        loginResponse.fold(
          (failure) => emit(
            AuthErrorState(
              errorMessage: _getSignInFailureMessage(failure),
            ),
          ),
          (user) {
            CurrentUser.set(user);
            emit(AuthSignInSuccessState(user: user));
          },
        );
      } else if (event is LogOutEvent) {
        emit(AuthLodingState());
        final loginResponse = await logoutUsecase();
        loginResponse.fold(
          (failure) => emit(const AuthErrorState(errorMessage: SERVER_ERROR)),
          (_) => emit(AuthLogoutSuccessState()),
        );
      } else if (event is ChangePasswordVisibilityEvent) {
        isPassword = !isPassword;
        if (isPassword) {
          emit(ChangePasswordVisibilityOffState());
        } else {
          emit(ChangePasswordVisibilityOnState());
        }
      } else if (event is PickDateEvent) {
        emit(PickDateState(date: event.date));
      } else if (event is ReturnToInitialEvent) {
        emit(AuthInitial());
      }
    });
  }

  String _getLoginFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthInvalidEmailFailure:
        return INVALID_EMAIL;
      case AuthWrongPasswordFailure:
        return WRONG_PASSWORD;
      case AuthUserNotFountFailure:
        return USER_NOT_FOUND;
      case AuthLocalUserNotFountFailure:
        return USER_NOT_FOUND;
      case ServerFailure:
        return SERVER_ERROR;
      case UnexpectedDatabaseFailure:
        return EMPTY_CACHE_ERROR;
      default:
        return UNEXPECTED_ERROR;
    }
  }

  String _getSignInFailureMessage(Failure failure) {
    switch (failure.runtimeType) {
      case AuthInvalidEmailFailure:
        return INVALID_EMAIL;
      case AuthWeakPasswordFailure:
        return WEEK_PASSWORD;
      case AuthAlreadyExistFailure:
        return EMAIL_ALREADY_EXISTS;
      case InsertingExistsUserFailure:
        return INSERTING_EXISTS_USER;
      case InsertingNullFailure:
        return INSERTING_NULL;
      case ServerFailure:
        return SERVER_ERROR;
      case UnexpectedDatabaseFailure:
        return EMPTY_CACHE_ERROR;
      default:
        return UNEXPECTED_ERROR;
    }
  }
}

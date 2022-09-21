part of 'profile_bloc.dart';

abstract class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class UpdateUserLoadingState extends ProfileState {}

class UpdateUserSuccessState extends ProfileState {}

class UpdateUserErrorState extends ProfileState {
  // final String message;

  // const UpdateUserErrorState({required this.message});

  // @override
  // List<Object> get props => [message];
}

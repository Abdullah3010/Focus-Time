part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  const ProfileEvent();

  @override
  List<Object> get props => [];
}

class UpdateUserEvent extends ProfileEvent {
  final UserModel user;

  const UpdateUserEvent({required this.user});

  @override
  List<Object> get props => [user];
}

part of 'group_usecases_bloc.dart';

abstract class GroupUsecasesEvent extends Equatable {
  const GroupUsecasesEvent();

  @override
  List<Object> get props => [];
}

class CreateGroupEvent extends GroupUsecasesEvent {
  final String groupName;
  final String groupDescription;
  final UserModel groupOwner;

  const CreateGroupEvent({
    required this.groupName,
    required this.groupDescription,
    required this.groupOwner,
  });

  @override
  List<Object> get props => [
        groupName,
        groupDescription,
        groupOwner,
      ];
}

class GetAllGroupsEvent extends GroupUsecasesEvent {}
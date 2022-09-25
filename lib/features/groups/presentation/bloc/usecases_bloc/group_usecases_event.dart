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
  final List<String> groupMembers;

  const CreateGroupEvent({
    required this.groupName,
    required this.groupDescription,
    required this.groupOwner,
    required this.groupMembers,
  });

  @override
  List<Object> get props => [
        groupName,
        groupDescription,
        groupOwner,
        groupMembers,
      ];
}

class GetAllGroupsEvent extends GroupUsecasesEvent {}

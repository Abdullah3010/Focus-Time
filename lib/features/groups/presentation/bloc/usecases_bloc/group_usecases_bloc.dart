import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/domain/usecases/create_group.dart';
import 'package:focus_time/features/groups/domain/usecases/get_all_groups.dart';
import 'package:focus_time/features/groups/domain/usecases/get_all_users.dart';
import 'package:focus_time/features/groups/domain/usecases/get_user_usecase.dart';

part 'group_usecases_event.dart';
part 'group_usecases_state.dart';

class GroupUsecasesBloc extends Bloc<GroupUsecasesEvent, GroupUsecasesState> {
  final CreateGroupUsecase createGroupUsecase;
  final GetAllGroupsUsecase getAllGroupsUsecase;
  final GetUserUsecase getUserUsecase;
  final GetAllUsersUsecase getAllUsersUsecase;

  List<GroupModel> groups = [];
  GroupUsecasesBloc({
    required this.createGroupUsecase,
    required this.getAllGroupsUsecase,
    required this.getUserUsecase,
    required this.getAllUsersUsecase,
  }) : super(GroupUsecasesInitial()) {
    on<GroupUsecasesEvent>(
      (event, emit) async {
        if (event is CreateGroupEvent) {
          emit(GroupUsecasesLoading());
          final result = await createGroupUsecase(
            groupName: event.groupName,
            groupDescription: event.groupDescription,
            groupOwner: event.groupOwner,
            groupMembers: event.groupMembers,
          );
          result.fold(
            (l) => emit(GroupUsecasesError()),
            (r) => emit(GroupUsecasesSuccess()),
          );
        } else if (event is GetAllGroupsEvent) {
          emit(GroupUsecasesLoading());
          final result = await getAllGroupsUsecase();
          result.fold(
            (l) => emit(GroupUsecasesError()),
            (responseGroups) {
              groups.addAll(responseGroups);
              emit(GroupUsecasesSuccess());
            },
          );
        } else if (event is GetUserEvent) {
          emit(GroupUsecasesLoading());
          final result = await getUserUsecase(event.uId);
          result.fold(
            (l) => emit(GroupUsecasesError()),
            (r) {
              groupMembers.add(r);
              emit(GroupUsecasesSuccess());
            },
          );
        } else if (event is GetAllUsersEvent) {
          emit(GroupUsecasesLoading());
          final result = await getAllUsersUsecase();
          result.fold(
            (l) => emit(GroupUsecasesError()),
            (users) {
              allUsers.addAll(users);
              emit(GroupUsecasesSuccess());
            },
          );
        }
      },
    );
  }

  List<UserModel> allUsers = [];

  TextEditingController groupNameController = TextEditingController();
  TextEditingController groupDescriptionController = TextEditingController();
  List<UserModel> groupMembers = [];
  List<String> groupMembersUId = [];

  void addMember(UserModel user) {
    try {
      groupMembers.firstWhere((u) => u.userId == user.userId);  
      print("object");
    } catch (e) {
      groupMembers.add(user);
      emit(AddUserToGroupState(user));
    }
  }
}

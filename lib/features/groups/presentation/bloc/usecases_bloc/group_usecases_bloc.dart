import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/domain/usecases/create_group.dart';
import 'package:focus_time/features/groups/domain/usecases/get_all_groups.dart';

part 'group_usecases_event.dart';
part 'group_usecases_state.dart';

class GroupUsecasesBloc extends Bloc<GroupUsecasesEvent, GroupUsecasesState> {
  final CreateGroupUsecase createGroupUsecase;
  final GetAllGroupsUsecase getAllGroupsUsecase;

  GroupUsecasesBloc({
    required this.createGroupUsecase,
    required this.getAllGroupsUsecase,
  }) : super(GroupUsecasesInitial()) {
    on<GroupUsecasesEvent>(
      (event, emit) async {
        if (event is CreateGroupEvent) {
          emit(GroupUsecasesLoading());
          final result = await createGroupUsecase(
            groupName: event.groupName,
            groupDescription: event.groupDescription,
            groupOwner: event.groupOwner,
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
            (r) {
              print(r);
              emit(GroupUsecasesSuccess());
            },
          );
        }
      },
    );
  }
}

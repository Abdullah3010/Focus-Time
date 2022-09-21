import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/profile/domain/usecases/update_user_usecase.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  UpdateUserUseCase updateUserUseCase;
  ProfileBloc({
    required this.updateUserUseCase,
  }) : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) async {
      if (event is UpdateUserEvent) {
        UpdateUserLoadingState();
        final response = await updateUserUseCase(event.user);
        response.fold(
          (l) => emit(UpdateUserErrorState()),
          (r) => emit(UpdateUserSuccessState()),
        );
      }
    });
  }
}

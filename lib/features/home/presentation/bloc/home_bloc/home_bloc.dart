import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:focus_time/features/profile/presentation/screens/profile_screen.dart';
import 'package:focus_time/features/settings/presentation/screens/settings_screen.dart';
import 'package:focus_time/features/tasks/presentation/screens/tasks_screen.dart';
import 'package:focus_time/features/tasks_matrix/presentation/screens/tasks_matrix_screen.dart';
import 'package:focus_time/features/groups/presentation/screens/groups_screen.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  int screenIndex = 2;

  final List<Widget> screens = [
    GroupsScreen(),
    TasksMatrixScreen(),
    TasksScreen(),
    ProfileScreen(),
    SettingsScreen(),
  ];

  HomeBloc() : super(HomeInitial()) {
    on<HomeEvent>((event, emit) {
      if (event is ChangeNavigationBarScreenEvent) {
        screenIndex = event.index;
        emit(ChangeNavigationBarScreenState(event.index));
      }
    });
  }
}

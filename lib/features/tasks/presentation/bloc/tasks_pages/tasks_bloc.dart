import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'tasks_event.dart';
part 'tasks_state.dart';

class TasksBloc extends Bloc<TasksEvent, TasksState> {
  int currentPage = 1;
  TasksBloc() : super(TasksInitial()) {
    on<TasksEvent>((event, emit) {
      if (event is ChangeTabBarPageEvent) {
        currentPage = event.indexPage;
        emit(ChangeTabBarPageState(event.indexPage));
      }
    });
  }
}

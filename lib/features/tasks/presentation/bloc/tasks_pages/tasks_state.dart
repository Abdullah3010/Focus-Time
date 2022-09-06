part of 'tasks_bloc.dart';

abstract class TasksState extends Equatable {
  const TasksState();

  @override
  List<Object> get props => [];
}

class TasksInitial extends TasksState {}

class ChangeTabBarPageState extends TasksState {
  final int indexPage;

  const ChangeTabBarPageState(this.indexPage);
  @override
  List<Object> get props => [indexPage];
}



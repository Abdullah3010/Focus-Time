part of 'tasks_bloc.dart';

abstract class TasksEvent extends Equatable {
  const TasksEvent();

  @override
  List<Object> get props => [];
}

class ChangeTabBarPageEvent extends TasksEvent {
  final int indexPage;

  const ChangeTabBarPageEvent(this.indexPage);

  @override
  List<Object> get props => [indexPage];
}

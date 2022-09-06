part of 'task_usecases_bloc.dart';

abstract class TaskUsecasesEvent extends Equatable {
  const TaskUsecasesEvent();

  @override
  List<Object> get props => [];
}

class AddTaskEvent extends TaskUsecasesEvent {
  final TaskModel task;

  const AddTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class UpdateTaskEvent extends TaskUsecasesEvent {
  final TaskModel task;

  const UpdateTaskEvent({required this.task});

  @override
  List<Object> get props => [task];
}

class GetAllTasksEvent extends TaskUsecasesEvent {
  const GetAllTasksEvent();

  @override
  List<Object> get props => [];
}

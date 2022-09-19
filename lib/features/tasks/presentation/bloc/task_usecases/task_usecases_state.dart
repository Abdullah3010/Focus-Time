part of 'task_usecases_bloc.dart';

abstract class TaskUsecasesState extends Equatable {
  const TaskUsecasesState();

  @override
  List<Object> get props => [];
}

class TaskUsecasesInitial extends TaskUsecasesState {}

class PickDateState extends TaskUsecasesState {}

class ChangeScoreState extends TaskUsecasesState {}

class AddTaskSuccessState extends TaskUsecasesState {}

class AddTaskLoadingState extends TaskUsecasesState {}

class AddTaskErrorState extends TaskUsecasesState {}

class UpdateTaskSuccessState extends TaskUsecasesState {}

class UpdateTaskLoadingState extends TaskUsecasesState {}

class UpdateTaskErrorState extends TaskUsecasesState {}

class GetAllTasksSuccessState extends TaskUsecasesState {}

class GetAllTasksSuccessAndEmptyState extends TaskUsecasesState {}

class GetAllTasksLoadingState extends TaskUsecasesState {}

class GetAllTasksErrorState extends TaskUsecasesState {}

class CahngeIsCompletedState extends TaskUsecasesState {
  final bool isCompleted;

  const CahngeIsCompletedState(this.isCompleted);
  @override
  List<Object> get props => [isCompleted];
}

class CahngeImportanceState extends TaskUsecasesState {
  final String importace;

  const CahngeImportanceState(this.importace);
  @override
  List<Object> get props => [importace];
}

class CahngeTimeTechniqueState extends TaskUsecasesState {
  final String timeTechnique;

  const CahngeTimeTechniqueState(this.timeTechnique);
  @override
  List<Object> get props => [timeTechnique];
}

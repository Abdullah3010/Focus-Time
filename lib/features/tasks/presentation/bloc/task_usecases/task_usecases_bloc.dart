import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/domain/usecases/add_task.dart';
import 'package:focus_time/features/tasks/domain/usecases/get_all_tasks.dart';
import 'package:focus_time/features/tasks/domain/usecases/update_task.dart';
import 'package:intl/intl.dart';
part 'task_usecases_event.dart';
part 'task_usecases_state.dart';

class TaskUsecasesBloc extends Bloc<TaskUsecasesEvent, TaskUsecasesState> {
  TaskModel? currentTask;
  final AddTaskUsecase addTaskUsecase;
  final GetAllTasksUsecase getAllTasksUsecase;
  final UpdateTaskUsecase updateTaskUsecase;

  List<TaskModel> allTasks = [];
  TaskUsecasesBloc({
    required this.addTaskUsecase,
    required this.getAllTasksUsecase,
    required this.updateTaskUsecase,
  }) : super(TaskUsecasesInitial()) {
    on<TaskUsecasesEvent>((event, emit) async {
      if (event is AddTaskEvent) {
        emit(AddTaskLoadingState());
        final response = await addTaskUsecase(event.task);
        response.fold(
          (failure) => emit(AddTaskErrorState()),
          (task) {
            allTasks.add(task);
            emit(AddTaskSuccessState());
          },
        );
      } else if (event is GetAllTasksEvent) {
        emit(GetAllTasksLoadingState());
        allTasks.clear();
        final response = await getAllTasksUsecase();
        response.fold(
          (failure) => emit(GetAllTasksErrorState()),
          (tasks) {
            allTasks.addAll(tasks);
            emit(GetAllTasksSuccessState());
          },
        );
      } else if (event is UpdateTaskEvent) {
        emit(UpdateTaskLoadingState());
        final response = await updateTaskUsecase(event.task);
        response.fold(
          (failure) => emit(UpdateTaskErrorState()),
          (_) {
            emit(UpdateTaskSuccessState());
          },
        );
      }
    });
  }
  bool importanceFocused = false;
  bool timeTechniqueFocused = false;
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDescriptionController =
      TextEditingController();
  final TextEditingController deadlineController = TextEditingController();
  final ValueNotifier<String> importanceValue =
      ValueNotifier('Not Urgent & Not Important');
  final ValueNotifier<String> timeTechniqueValue =
      ValueNotifier('25m Work 5m Breack');
  DateTime? deadlineDate;

  void pickDate(DateTime date, {bool isUpdated = false}) {
    var formatter = DateFormat('yyyy-MM-dd hh:mm aaa');
    if (isUpdated) {
      updatedDeadlineDate = date;
      updatedDeadlineController.text = formatter.format(date);
    } else {
      deadlineDate = date;
      deadlineController.text = formatter.format(date);
    }
    emit(PickDateState());
  }

  void changeImportanceValue(String value, {bool isUpdated = false}) {
    if (isUpdated) {
      updatedImportanceValue.value = importanceString[value]!;
    } else {
      importanceValue.value = importanceString[value]!;
    }
    emit(CahngeImportanceState(value));
  }

  void changeTimeTechniqueValue(String value, {bool isUpdated = false}) {
    if (isUpdated) {
      updatedTimeTechniqueValue.value = timeTechnique[value]!;
    } else {
      timeTechniqueValue.value = timeTechnique[value]!;
    }
    emit(CahngeTimeTechniqueState(value));
  }

  void changeIsCompleted(TaskModel task) {
    try {
      updateTaskUsecase(task);
      // emit(CahngeIsCompletedState(task.isCompleted!));
      emit(UpdateTaskSuccessState());
    } catch (e) {
      rethrow;
    }
  }

  String getImportanceString(String value) {
    return value.compareTo('Select importance of task') == 0
        ? 'NU-NI'
        : importanceKey[value]!;
  }

  double getTimeTechniqueString(String value) {
    return double.parse(value.split(' ')[0].substring(0, 2));
  }

  void clearAllFields() {
    deadlineController.clear();
    taskDescriptionController.clear();
    taskNameController.clear();
    importanceFocused = false;
    importanceValue.value = 'Select importance of task';
  }

  bool updatedImportanceFocused = false;
  bool updatedTimeTechniqueFocused = false;
  final TextEditingController updatedTaskNameController =
      TextEditingController();
  final TextEditingController updatedTaskDescriptionController =
      TextEditingController();
  final TextEditingController updatedDeadlineController =
      TextEditingController();
  final ValueNotifier<String> updatedImportanceValue =
      ValueNotifier('Select importance of task');
  final ValueNotifier<String> updatedTimeTechniqueValue =
      ValueNotifier('Select time technique of task');
  DateTime? updatedDeadlineDate;

  void prepareUpdateScreen() {
    print(currentTask);
    updatedTaskNameController.text = currentTask!.taskName;
    updatedTaskDescriptionController.text = currentTask!.taskDescription;
    updatedImportanceFocused = true;
    updatedImportanceValue.value = importanceString[currentTask!.importance]!;
    updatedTimeTechniqueFocused = true;
    updatedTimeTechniqueValue.value =
        timeTechnique[currentTask!.timeTechnique.toInt().toString()]!;
    var formatter = DateFormat('yyyy-MM-dd hh:mm aaa');
    updatedDeadlineDate = currentTask!.deadline.toDate();
    updatedDeadlineController.text = formatter.format(updatedDeadlineDate!);
  }
}

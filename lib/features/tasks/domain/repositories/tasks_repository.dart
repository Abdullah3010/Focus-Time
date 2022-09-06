import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';

abstract class TasksRepository {
  Future<Either<Failure, TaskModel>> addTask(TaskModel task);
  Future<Either<Failure, Unit>> updateTask(TaskModel task);
  Future<Either<Failure, List<TaskModel>>> getAllTasks();
}

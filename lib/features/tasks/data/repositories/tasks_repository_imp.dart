import 'package:focus_time/core/network/network_info.dart';
import 'package:focus_time/features/tasks/data/datasources/task_local_date_source.dart';
import 'package:focus_time/features/tasks/data/datasources/task_remote_date_source.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/features/tasks/domain/repositories/tasks_repository.dart';

class TasksRepositoryImp extends TasksRepository {
  final TaskRemoteDataSource taskRemoteDateSource;
  final TaskLocalDataSource taskLocalDateSource;
  final NetworkInfo networkInfo;

  TasksRepositoryImp({
    required this.taskRemoteDateSource,
    required this.taskLocalDateSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, TaskModel>> addTask(TaskModel task) async {
    try {
      final addedTask = await taskRemoteDateSource.addTask(task);
      return Right(addedTask);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, List<TaskModel>>> getAllTasks() async {
    try {
      return Right(await taskRemoteDateSource.getAllTasks());
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Either<Failure, Unit>> updateTask(TaskModel task) async {
    try {
      return Right(await taskRemoteDateSource.updateTask(task));
    } catch (e) {
      rethrow;
    }
  }
}

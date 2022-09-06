import 'package:dartz/dartz.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';

abstract class TaskLocalDataSource {
  Future<Unit> localAddTask(TaskModel task);
}

class TaskLocalImpWithSqflite extends TaskLocalDataSource {
  @override
  Future<Unit> localAddTask(TaskModel task) {
    // TODO: implement addTask
    throw UnimplementedError();
  }
}

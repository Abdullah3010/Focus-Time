import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/domain/repositories/tasks_repository.dart';

class AddTaskUsecase {
  final TasksRepository taskRepository;

  AddTaskUsecase(this.taskRepository);

  Future<Either<Failure, TaskModel>> call(TaskModel task) async {
    return await taskRepository.addTask(task);
  }
}

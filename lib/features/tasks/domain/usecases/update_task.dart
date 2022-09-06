import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/domain/repositories/tasks_repository.dart';

class UpdateTaskUsecase {
  final TasksRepository tasksRepository;

  UpdateTaskUsecase(this.tasksRepository);

  Future<Either<Failure, Unit>> call(TaskModel task) async {
    return await tasksRepository.updateTask(task);
  }
}

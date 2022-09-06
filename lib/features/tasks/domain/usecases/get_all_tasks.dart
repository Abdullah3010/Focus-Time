import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/domain/repositories/tasks_repository.dart';

class GetAllTasksUsecase {
  final TasksRepository tasksRepository;

  GetAllTasksUsecase(this.tasksRepository);

  Future<Either<Failure, List<TaskModel>>> call() async {
    return await tasksRepository.getAllTasks();
  }
}

import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/domain/repositories/group_repository.dart';

class GetAllUsersUsecase {
  final GroupRepository groupRepository;

  GetAllUsersUsecase(this.groupRepository);

  Future<Either<Failure, List<UserModel>>> call() async {
    return await groupRepository.getAllUsers();
  }
}

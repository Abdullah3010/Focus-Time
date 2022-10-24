import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/domain/repositories/group_repository.dart';

class GetUserUsecase {
  final GroupRepository groupRepository;

  GetUserUsecase(this.groupRepository);

  Future<Either<Failure, UserModel>> call(String uId) async {
    return await groupRepository.getUser(uId);
  }
}

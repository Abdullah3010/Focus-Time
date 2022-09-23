import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/domain/repositories/group_repository.dart';



class CreateGroupUsecase {
  final GroupRepository groupRepository;

  CreateGroupUsecase(this.groupRepository);

  Future<Either<Failure, GroupModel>> call({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
  }) async {
    return await groupRepository.createGroup(
      groupName: groupName,
      groupDescription: groupDescription,
      groupOwner: groupOwner,
    );
  }
}
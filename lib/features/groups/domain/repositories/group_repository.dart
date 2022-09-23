import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';

abstract class GroupRepository {
  Future<Either<Failure, GroupModel>> createGroup({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
  });
  Future<Either<Failure, List<GroupModel>>>  getAllGroups();
}

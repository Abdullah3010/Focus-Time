import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/features/groups/data/datasources/group_remote_date_source.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/domain/repositories/group_repository.dart';

class GroupRepositoryImp extends GroupRepository {
  final GroupRemoteDataSource groupRemoteDateSource;

  GroupRepositoryImp({
    required this.groupRemoteDateSource,
  });

  @override
  Future<Either<Failure, GroupModel>> createGroup({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
    required List<String> groupMembers,
  }) async {
    try {
      final group = await groupRemoteDateSource.createGroup(
        groupName: groupName,
        groupDescription: groupDescription,
        groupOwner: groupOwner,
        groupMembers: groupMembers,
      );
      return Right(group);
    } catch (e) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<GroupModel>>> getAllGroups() async {
    try {
      final groups = await groupRemoteDateSource.getAllGroups();
      return Right(groups);
    } catch (e) {
      return Left(ServerFailure());
    }
  }
}

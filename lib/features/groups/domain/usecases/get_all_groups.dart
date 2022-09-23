import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/failures.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/domain/repositories/group_repository.dart';

class GetAllGroupsUsecase {
  final GroupRepository groupRepository;

  GetAllGroupsUsecase(this.groupRepository);

  Future<Either<Failure, List<GroupModel>>> call() async {
    return await groupRepository.getAllGroups();
  }
}
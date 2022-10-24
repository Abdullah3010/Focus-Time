import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/core/errors/errors_exceptions.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';

abstract class GroupRemoteDataSource {
  Future<GroupModel> createGroup({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
    required List<String> groupMembers,
  });

  Future<List<GroupModel>> getAllGroups();
  Future<List<UserModel>> getAllUsers();
  Future<UserModel> getUser(String uId);
}

class GroupRemoteImpWithFirebase extends GroupRemoteDataSource {
  final FirebaseFirestore firestore;

  GroupRemoteImpWithFirebase({
    required this.firestore,
  });

  @override
  Future<GroupModel> createGroup({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
    required List<String> groupMembers,
  }) async {
    try {
      final group = GroupModel(
        groupName: groupName,
        groupDescription: groupDescription,
        groupOwner: groupOwner,
        groupMembers: groupMembers,
        createdDate: Timestamp.fromDate(DateTime.now()),
      );
      final groupRef = firestore.collection('groups').doc();
      group.groupId = groupRef.id;
      await groupRef.set(group.toJson());
      return Future.value(group);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<GroupModel>> getAllGroups() async {
    try {
      final groups = await firestore.collection('groups').get();
      final groupList = groups.docs.map((group) {
        final groupData = group.data();
        if (groupData['group_owner'] == CurrentUser.get()!.userId) {
          return GroupModel.fromJson(
            groupData,
            CurrentUser.get()!,
          );
        } else {
          throw ServerException();
        }
      }).toList();
      return Future.value(groupList);
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  @override
  Future<List<UserModel>> getAllUsers() async {
    try {
      final users = await firestore.collection('users').get();
      final usersList = users.docs.map((user) {
        return UserModel.fromJson(
          user.data(),
        );
      }).toList();
      return Future.value(usersList);
    } catch (e) {
      print(e);
      rethrow;
    }
  }
  
  @override
  Future<UserModel> getUser(String uId) async {
    try {
      final result = await firestore.collection('users').doc(uId).get();
      final user = UserModel.fromJson(result.data()!);
        return Future.value(user);
    } catch (e) {
      rethrow;
    }
  }
}

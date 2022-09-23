import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:focus_time/core/errors/errors_exceptions.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class GroupRemoteDataSource {
  Future<GroupModel> createGroup({
    required String groupName,
    required String groupDescription,
    required UserModel groupOwner,
  });

  Future<List<GroupModel>> getAllGroups();
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
  }) async {
    try {
      final group = GroupModel(
        groupName: groupName,
        groupDescription: groupDescription,
        groupOwner: groupOwner,
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
        if (groupData['groupOwner'] == CurrentUser.get()!.userId) {
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
      rethrow;
    }
  }
}

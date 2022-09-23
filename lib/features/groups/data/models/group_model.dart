import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/auth/domain/entities/user_auth.dart';
import 'package:focus_time/features/groups/domain/entities/group_entity.dart';

class GroupModel extends GroupEntity {

  GroupModel({
    super.groupId,
    required super.groupName,
    required super.groupDescription,
    required super.groupOwner,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json,UserModel owner) {
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['groupName'],
      groupDescription:  json['groupDescription'],
      groupOwner:  owner,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'groupName': groupName,
      'groupDescription': groupDescription,
      'groupOwner': groupOwner.userId,
    };
  }
}

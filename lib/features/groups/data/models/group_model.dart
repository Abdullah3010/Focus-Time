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
    required super.groupMembers,
    required super.createdDate,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json, UserModel owner) {
    final groupMemberList = json['group_members'].map<String>((member) {
      return member.toString();
    }).toList();
    return GroupModel(
      groupId: json['groupId'],
      groupName: json['group_name'],
      groupDescription: json['group_description'],
      groupOwner: owner,
      groupMembers: groupMemberList,
      createdDate: json['created_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'groupId': groupId,
      'group_name': groupName,
      'group_description': groupDescription,
      'group_owner': groupOwner.userId,
      'group_members': groupMembers,
      'created_date': createdDate,
    };
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

class GroupEntity extends Equatable {
  String? groupId;
  final String groupName;
  final String groupDescription;
  final UserModel groupOwner;
  final List<String> groupMembers;
  final Timestamp createdDate;
  final DocumentReference groupMembersRef;

  GroupEntity({
    this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupOwner,
    required this.groupMembers,
    required this.createdDate,
  });

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        groupDescription,
        groupOwner,
        groupMembers,
        createdDate,
      ];
}

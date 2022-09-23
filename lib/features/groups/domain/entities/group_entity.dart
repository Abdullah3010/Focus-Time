import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';

class GroupEntity extends Equatable {
  String? groupId;
  final String groupName;
  final String groupDescription;
  final UserModel groupOwner;

  GroupEntity({
    this.groupId,
    required this.groupName,
    required this.groupDescription,
    required this.groupOwner,
  });

  @override
  List<Object?> get props => [
        groupId,
        groupName,
        groupDescription,
        groupOwner,
      ];
}

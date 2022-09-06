import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class TaskEntity extends Equatable {
  String? taskId;
  final String taskName;
  final String taskDescription;
  final Timestamp deadline;
  final double timeTechnique;
  double score;
  bool? isCompleted;
  final Timestamp createTime;
  Duration progressInMinutes;
  final String importance;

  TaskEntity({
    this.taskId,
    required this.taskName,
    required this.taskDescription,
    required this.deadline,
    required this.timeTechnique,
    required this.score,
    required this.isCompleted,
    required this.createTime,
    required this.progressInMinutes,
    required this.importance,
  });

  @override
  List<Object?> get props => [
        taskId,
        taskName,
        taskDescription,
        deadline,
        timeTechnique,
        score,
        progressInMinutes,
        importance,
      ];
}

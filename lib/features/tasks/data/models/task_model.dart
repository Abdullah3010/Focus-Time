import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/tasks/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.taskId,
    required super.taskName,
    required super.taskDescription,
    required super.deadline,
    required super.timeTechnique,
    required super.score,
    required super.isCompleted,
    required super.createTime,
    required super.progressInMinutes,
    required super.importance,
  });

  factory TaskModel.fromJson(Map<String, dynamic> json) {
    return TaskModel(
      taskId: json['taskId'],
      taskName: json['taskName'],
      taskDescription: json['taskDescription'],
      deadline: json['deadline'],
      timeTechnique: double.parse(json['timeTechnique'].toString()),
      score: double.parse(json['score'].toString()),
      isCompleted: json['isCompleted'],
      createTime: json['createTime'],
      progressInMinutes: Duration(minutes: json['progressInMinutes']),
      importance: json['importance'],
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'taskId': taskId,
      'taskName': taskName,
      'taskDescription': taskDescription,
      'deadline': deadline,
      'timeTechnique': timeTechnique,
      'score': score,
      'isCompleted': isCompleted,
      'createTime': createTime,
      'progressInMinutes': progressInMinutes.inMinutes,
      'importance': importance,
    };
  }
}

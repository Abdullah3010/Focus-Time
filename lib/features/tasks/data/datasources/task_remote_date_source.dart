import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';

abstract class TaskRemoteDataSource {
  Future<TaskModel> addTask(TaskModel task);
  Future<Unit> updateTask(TaskModel task);
  Future<List<TaskModel>> getAllTasks();
}

class TaskRemoteImpWithFirebase extends TaskRemoteDataSource {
  final FirebaseFirestore firestore;

  TaskRemoteImpWithFirebase({required this.firestore});

  @override
  Future<TaskModel> addTask(TaskModel task) async {
    try {
      final addedTask = await firestore
          .collection('all_users_tasks')
          .doc(CurrentUser.get()!.userId)
          .collection('tasks')
          .add(task.toMap());
      task.taskId = addedTask.id;
      await firestore
          .collection('all_users_tasks')
          .doc(CurrentUser.get()!.userId)
          .collection('tasks')
          .doc(addedTask.id)
          .update(task.toMap());
      return task;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<TaskModel>> getAllTasks() async {
    try {
      final getTasksResponse = await firestore
          .collection('all_users_tasks')
          .doc(CurrentUser.get()!.userId)
          .collection('tasks')
          .get();
      final listOfDocs = getTasksResponse.docs;
      final allTasks = listOfDocs
          .map((docTask) => TaskModel.fromJson(docTask.data()))
          .toList();
      return allTasks;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<Unit> updateTask(TaskModel task) async {
    try {
      await firestore
          .collection('all_users_tasks')
          .doc(CurrentUser.get()!.userId)
          .collection('tasks')
          .doc(task.taskId)
          .update(task.toMap());
      return Future.value(unit);
    } catch (e) {
      rethrow;
    }
  }
}

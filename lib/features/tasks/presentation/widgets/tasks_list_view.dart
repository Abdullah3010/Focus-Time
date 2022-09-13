import 'package:flutter/material.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/widgets/task_widget.dart';

class TasksListView extends StatelessWidget {
  final List<TaskModel> tasks;
  const TasksListView({
    super.key,
    required this.tasks,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        return TaskWidget(
          task: tasks[index],
        );
      },
      separatorBuilder: (context, index) => const SizedBox(
        height: 20,
      ),
    );
  }
}

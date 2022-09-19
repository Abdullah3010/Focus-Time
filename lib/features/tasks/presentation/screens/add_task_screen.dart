import 'package:flutter/material.dart';
import 'package:focus_time/features/tasks/presentation/widgets/add_task_form.dart';

class AddTaskScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    return SingleChildScrollView(
      child: AddTaskForm(),
    );
  }
}

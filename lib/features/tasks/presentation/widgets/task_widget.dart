import 'package:flutter/material.dart';
import 'package:focus_time/core/task/task_importance.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/screens/task_details.dart';
import 'package:intl/intl.dart';

class TaskWidget extends StatelessWidget {
  final TaskModel task;

  const TaskWidget({required this.task});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: () {
          _onTap(context);
        },
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(5),
                  topRight: Radius.circular(20),
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(5),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: Text(
                      task.taskName,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(bottom: 5),
                    constraints: const BoxConstraints(
                      maxHeight: 45,
                      maxWidth: 250,
                    ),
                    child: Text(
                      task.taskDescription,
                      style: const TextStyle(
                        fontWeight: FontWeight.w300,
                        overflow: TextOverflow.fade,
                      ),
                      // textAlign: TextAlign.end,
                    ),
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Text(
                      _getDeadlineString(task.deadline.toDate()),
                      style: TextStyle(
                        color: _getDeadlineColor(task.deadline.toDate()),
                        fontWeight: FontWeight.w300,
                        height: 1.5,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 100,
              height: 30,
              decoration: BoxDecoration(
                color: importanceColor[task.importance],
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  topRight: Radius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getDeadlineString(DateTime deadline) {
    return DateFormat('yyyy-MM-dd\nhh:mm aaa').format(deadline);
  }

  Color _getDeadlineColor(DateTime deadline) {
    return deadline.isAfter(DateTime.now()) ? Colors.green : AppColors.error;
  }

  Function()? _onTap(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskDetails(
          task: task,
        ),
      ),
    );
    return null;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/tasks/data/models/task_model.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/task_widget.dart';
import 'package:focus_time/features/tasks/presentation/widgets/tasks_list_view.dart';

class CompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        final List<TaskModel> completedTasks = [];
        if (bloc.allTasks.isEmpty && state is! GetAllTasksLoadingState) {
          bloc.add(const GetAllTasksEvent());
        } else {
          for (var task in bloc.allTasks) {
            if (task.isCompleted!) {
              completedTasks.add(task);
            }
          }
        }
        return StretchScrollWidget(
          child: TasksListView(tasks: completedTasks),
        );
      },
    );
  }
}

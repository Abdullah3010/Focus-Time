import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/task_widget.dart';

class CompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        final completedTasks = [];
        if (bloc.allTasks.isEmpty && state is! GetAllTasksLoadingState) {
          bloc.add(const GetAllTasksEvent());
        } else {
          for (var task in bloc.allTasks) {
            if (task.isCompleted!) {
              completedTasks.add(task);
            }
          }
        }
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: StretchingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            child: ListView.separated(
              itemCount: completedTasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(
                  task: completedTasks[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(
                height: 20,
              ),
            ),
          ),
        );
      },
    );
  }
}

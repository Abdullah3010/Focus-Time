import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/task_widget.dart';

class UncompletedScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        final uncompletedTasks = [];
        if (bloc.allTasks.isEmpty && state is! GetAllTasksLoadingState) {
          bloc.add(const GetAllTasksEvent());
        } else {
          for (var task in bloc.allTasks) {
            if (!task.isCompleted!) {
              uncompletedTasks.add(task);
            }
          }
        }
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: StretchingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            child: ListView.separated(
              itemCount: uncompletedTasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(
                  task: uncompletedTasks[index],
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

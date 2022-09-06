import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/task_widget.dart';

class AllTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        if ((bloc.allTasks.isEmpty && state is! GetAllTasksLoadingState) ||
            state is UpdateTaskSuccessState) {
          bloc.add(const GetAllTasksEvent());
        }
        return ScrollConfiguration(
          behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
          child: StretchingOverscrollIndicator(
            axisDirection: AxisDirection.down,
            child: ListView.separated(
              itemCount: bloc.allTasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(
                  task: bloc.allTasks[index],
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

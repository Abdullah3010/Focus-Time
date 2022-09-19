import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/tasks/presentation/bloc/task_usecases/task_usecases_bloc.dart';
import 'package:focus_time/features/tasks/presentation/widgets/tasks_list_view.dart';

class AllTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TaskUsecasesBloc, TaskUsecasesState>(
      builder: (context, state) {
        print(3);
        final bloc = BlocProvider.of<TaskUsecasesBloc>(context);
        if ((bloc.allTasks.isEmpty &&
                state is! GetAllTasksLoadingState &&
                state is! GetAllTasksSuccessAndEmptyState) ||
            state is UpdateTaskSuccessState) {
          bloc.add(const GetAllTasksEvent());
        }

        return StretchScrollWidget(
          child: TasksListView(
            tasks: bloc.allTasks,
          ),
        );
      },
    );
  }
}

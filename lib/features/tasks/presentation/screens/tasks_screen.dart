import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_time/features/tasks/presentation/bloc/tasks_pages/tasks_bloc.dart';
import 'package:focus_time/features/tasks/presentation/screens/add_task_screen.dart';
import 'package:focus_time/features/tasks/presentation/screens/all_tasks_screen.dart';
import 'package:focus_time/features/tasks/presentation/screens/completed_screen.dart';
import 'package:focus_time/features/tasks/presentation/screens/uncompleted_screen.dart';
import 'package:focus_time/features/tasks/presentation/widgets/top_nav_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const tabBarTitles = [
      'Add Task',
      'All Tasks',
      'Completed',
      'Uncompleted',
    ];
    const tabBarIcons = [
      Icons.add_outlined,
      FontAwesomeIcons.listCheck,
      FontAwesomeIcons.clipboardList,
      Icons.task,
    ];
    final tabBarScreens = [
      AddTaskScreen(),
      AllTasksScreen(),
      CompletedScreen(),
      UncompletedScreen(),
    ];

    return BlocBuilder<TasksBloc, TasksState>(
      builder: (context, state) {
        final bloc = BlocProvider.of<TasksBloc>(context);

        return Column(
          children: [
            TopNavBar(
              titles: tabBarTitles,
              icons: tabBarIcons,
              initialIndex: bloc.currentPage,
              onTap: (index) {
                bloc.add(ChangeTabBarPageEvent(index));
              },
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: tabBarScreens[bloc.currentPage],
              ),
            ),
          ],
        );
      },
    );
  }
}

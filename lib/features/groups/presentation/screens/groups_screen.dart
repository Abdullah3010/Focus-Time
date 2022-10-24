import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';
import 'package:focus_time/features/groups/presentation/screens/add_group_screen.dart';
import 'package:focus_time/features/groups/presentation/screens/group_details.dart';
import 'package:focus_time/features/groups/presentation/widgets/add_group.dart';
import 'package:focus_time/features/groups/presentation/widgets/group_item.dart';

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StretchScrollWidget(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: BlocBuilder<GroupUsecasesBloc, GroupUsecasesState>(
          builder: (context, state) {
            final bloc = BlocProvider.of<GroupUsecasesBloc>(context);
            if (state is GroupUsecasesInitial &&
                state is! GroupUsecasesLoading) {
              bloc.add(GetAllGroupsEvent());
            }
            return StaggeredGrid.count(
              crossAxisCount: 8,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: [
                AddGroup(),
                ...bloc.groups.map(
                  (group) => GroupItem(
                    group: group,
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

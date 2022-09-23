import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';

class GroupsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StretchScrollWidget(
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: BlocBuilder<GroupUsecasesBloc, GroupUsecasesState>(
          builder: (context, state) {
            return StaggeredGrid.count(
              crossAxisCount: 8,
              mainAxisSpacing: 20,
              crossAxisSpacing: 10,
              children: [
                StaggeredGridTile.count(
                  crossAxisCellCount: 4,
                  mainAxisCellCount: 3,
                  child: Container(
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
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(5),
                        topRight: Radius.circular(20),
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(5),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: InkWell(
                        onTap: () {
                          // BlocProvider.of<GroupUsecasesBloc>(context)
                          //     .add(CreateGroupEvent(
                          //   groupName: 'test',
                          //   groupDescription: 'test',
                          //   groupOwner: CurrentUser.get()!,
                          // ));
                          BlocProvider.of<GroupUsecasesBloc>(context)
                              .add(GetAllGroupsEvent());
                        },
                        splashColor: AppColors.primary.withOpacity(0.2),
                        highlightColor: Colors.grey.withOpacity(0.1),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Icon(
                                Icons.add,
                                size: 35,
                                color: AppColors.accent,
                              ),
                              SizedBox(height: 10),
                              Text(
                                'Add Group',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
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

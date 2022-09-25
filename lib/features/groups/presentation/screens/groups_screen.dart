import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/presentation/bloc/usecases_bloc/group_usecases_bloc.dart';
import 'package:focus_time/features/groups/presentation/screens/group_details.dart';

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
                addGridItem(context),
                ...bloc.groups.map(
                  (group) => groupGridItem(
                    context: context,
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

  StaggeredGridTile addGridItem(BuildContext context) {
    return StaggeredGridTile.count(
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
    );
  }

  StaggeredGridTile groupGridItem({
    required BuildContext context,
    required GroupModel group,
  }) {
    return StaggeredGridTile.count(
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => GroupDetails(
                    group: group,
                  ),
                ),
              );
            },
            splashColor: AppColors.primary.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.accent.withOpacity(0.8),
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(5),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  width: double.infinity,
                  height: double.infinity,
                  child: CustomPaint(
                    painter: GroupPainter(color: AppColors.accent),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        group.groupName,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class GroupPainter extends CustomPainter {
  final Color color;

  GroupPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    path.moveTo(0, size.height * 0.7);
    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.49,
      size.height * 0.8,
    );
    path.quadraticBezierTo(
      size.width * 0.8,
      size.height * 0.5,
      size.width,
      size.height * 0.7,
    );
    path.lineTo(size.width, 0);
    path.lineTo(0, 0);

    path.close();

    final painter = Paint()..color = color;
    canvas.drawShadow(path, Colors.black, 4.0, false);
    canvas.drawPath(path, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/features/groups/domain/usecases/get_all_users.dart';
import 'package:focus_time/features/groups/presentation/screens/add_group_screen.dart';
import 'package:focus_time/injector.dart';

class AddGroup extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddGroupScreen(),
                ),
              );
            },
            splashColor: AppColors.primary.withOpacity(0.2),
            highlightColor: Colors.grey.withOpacity(0.1),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.group_add_outlined,
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
}

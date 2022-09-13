import 'package:flutter/material.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class TopNavBar extends StatelessWidget {
  final titles = [
    'Add Task',
    'All Tasks',
    'Completed',
    'Uncompleted',
  ];
  final icons = [
    Icons.add_outlined,
    FontAwesomeIcons.listCheck,
    FontAwesomeIcons.clipboardList,
    Icons.task,
  ];
  final int initialIndex;
  final Function(int index) onTap;
  final List<Tab> tabBars = [];
  TopNavBar({
    required this.initialIndex,
    required this.onTap,
    super.key,
  }) {
    for (var i = 0; i < titles.length; i++) {
      tabBars.add(
        Tab(
          text: titles[i],
          icon: Icon(icons[i]),
        ),
      );
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 3,
          )
        ],
      ),
      child: Center(
        child: DefaultTabController(
          length: titles.length,
          initialIndex: initialIndex,
          child: TabBar(
            isScrollable: true,
            labelColor: AppColors.accent,
            labelStyle: const TextStyle(
              color: AppColors.accent,
              fontSize: 14,
            ),
            indicatorColor: AppColors.accent,
            unselectedLabelColor: AppColors.primary,
            unselectedLabelStyle: const TextStyle(
              color: AppColors.primary,
              fontSize: 12,
            ),
            indicatorWeight: 3,
            tabs: tabBars,
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

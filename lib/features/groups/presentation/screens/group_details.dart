import 'package:flutter/material.dart';
import 'package:focus_time/core/models/details_list_item.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/details_list.dart';
import 'package:focus_time/core/widgets/stretch_scroll_widget.dart';
import 'package:focus_time/features/groups/data/models/group_model.dart';
import 'package:focus_time/features/groups/presentation/screens/group_settings.dart';
import 'package:focus_time/features/groups/presentation/screens/members_screen.dart';

class GroupDetails extends StatelessWidget {
  final GroupModel group;

  const GroupDetails({super.key, required this.group});

  @override
  Widget build(BuildContext context) {
    final List<DetailsListItem> _groupDetailsItems = [
      DetailsListItem(
        route: MembersScreen(
          members: group.groupMembers,
        ),
        title: 'Tasks',
        icon: Icons.assignment,
      ),
      DetailsListItem(
        route: MembersScreen(
          members: group.groupMembers,
        ),
        title: 'Members',
        icon: Icons.people,
      ),
      DetailsListItem(
        route: GroupSettingsScreen(
          owner: group.groupOwner,
        ),
        title: 'Settings',
        icon: Icons.settings,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(group.groupName),
      ),
      body: StretchScrollWidget(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [
                Text(group.groupDescription),
                DetailsList(items: _groupDetailsItems),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:focus_time/core/models/details_list_item.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/details_list.dart';
import 'package:focus_time/features/profile/presentation/screens/account_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = CurrentUser.get();
    final List<DetailsListItem> _profileItems = [
      DetailsListItem(
        title: 'Account',
        icon: Icons.account_circle,
        route: AccountScreen(
          user: user!,
        ),
      ),
      DetailsListItem(
        title: 'Groups',
        icon: Icons.group,
        route: AccountScreen(
          user: user,
        ),
      ),
      DetailsListItem(
        title: 'Settings',
        icon: Icons.settings,
        route: AccountScreen(
          user: user,
        ),
      ),
      DetailsListItem(
        title: 'About',
        icon: Icons.info_outline,
        route: AccountScreen(
          user: user,
        ),
      ),
    ];

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            children: [
              CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.accent,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(200),
                  child: CircleAvatar(
                    radius: 75,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/imageBG.jpeg',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "${user.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              DetailsList(
                items: _profileItems,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

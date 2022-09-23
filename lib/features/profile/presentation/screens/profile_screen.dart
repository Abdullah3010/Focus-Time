import 'package:flutter/material.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/features/profile/presentation/screens/account_screen.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = CurrentUser.get();
    final List _profileItems = [
      {
        'index': 1,
        'title': 'Account',
        'icon': Icons.account_box_outlined,
        // 'route': '/account',
        'route': AccountScreen(
          user: user!,
        ),
      },
      {
        'index': 2,
        'title': 'Settings',
        'icon': Icons.settings,
        // 'route': '/settings',
        'route': AccountScreen(
          user: user,
        ),
      },
      {
        'index': 3,
        'title': 'About',
        'icon': Icons.info,
        // 'route': '/about',
        'route': AccountScreen(
          user: user,
        ),
      },
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
              Container(
                margin: const EdgeInsets.all(22),
                width: double.infinity,
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
                      color: Colors.black26,
                      blurRadius: 7,
                      offset: Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _profileItems.map((item) {
                    return _createRowDetails(
                      icon: item['icon'],
                      title: item['title'],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => item['route'],
                          ),
                        );
                      },
                      isLastRow: item['index'] == _profileItems.length,
                      isFristRow: item['index'] == 1,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _createRowDetails({
    required IconData icon,
    required String title,
    required Function onTap,
    bool? isLastRow,
    bool? isFristRow,
  }) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(isFristRow! ? 5 : 0),
        topRight: Radius.circular(20),
        bottomLeft: Radius.circular(20),
        bottomRight: Radius.circular(isLastRow! ? 5 : 0),
      ),
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () => onTap(),
        splashColor: AppColors.primary.withOpacity(0.2),
        highlightColor: Colors.grey.withOpacity(0.1),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 15,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Icon(
                      icon,
                      color: AppColors.accent,
                      size: 28,
                    ),
                  ),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: Colors.black26,
                    size: 22,
                  ),
                ],
              ),
            ),
            if (isLastRow == null || !isLastRow)
              const Divider(
                height: 1,
              ),
          ],
        ),
      ),
    );
  }

  // Widget _getRowDetails({
  //   required String fieldName,
  //   required String fieldDetails,
  // }) {
  //   return Padding(
  //     padding: const EdgeInsets.symmetric(horizontal: 8),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text(
  //           fieldName,
  //           style: const TextStyle(
  //             fontSize: 24,
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 8.0),
  //           child: Text(
  //             fieldDetails,
  //             style: const TextStyle(
  //               fontSize: 16,
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }
}

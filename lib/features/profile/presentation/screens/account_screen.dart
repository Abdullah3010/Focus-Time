import 'package:flutter/material.dart';
import 'package:focus_time/core/utils/app_colors.dart';
import 'package:focus_time/core/widgets/rounded_button.dart';
import 'package:focus_time/features/auth/data/models/user_model.dart';
import 'package:focus_time/features/profile/presentation/screens/update_account_screen.dart';
import 'package:intl/intl.dart';
import 'package:qr_flutter/qr_flutter.dart';

class AccountScreen extends StatelessWidget {
  final UserModel user;
  const AccountScreen({
    required this.user,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List userData = [
      {
        'index': 1,
        'title': '${user.firstName} ${user.lastName}',
        'icon': Icons.person,
      },
      {
        'index': 2,
        'title': user.email,
        'icon': Icons.email,
      },
      {
        'index': 3,
        'title': user.phone,
        'icon': Icons.phone,
      },
      {
        'index': 4,
        'title': DateFormat('EEEE, dd/MM/yyyy').format(user.birthdate.toDate()),
        'icon': Icons.calendar_today,
      },
      {
        'index': 5,
        'title': user.gender,
        'icon': Icons.wc,
      }
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
      ),
      body: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Container(
              padding: const EdgeInsets.only(
                top: 60,
                bottom: 10,
              ),
              margin: const EdgeInsets.only(
                right: 22,
                left: 22,
                top: 100,
              ),
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
                children: [
                  QrImage(
                    data: user.userId!,
                    version: QrVersions.auto,
                    size: 100.0,
                    foregroundColor: AppColors.primary,
                  ),
                  ...userData.map(
                    (item) {
                      return _createRowItem(
                        title: item['title'],
                        icon: item['icon'],
                        isLastRow: item['index'] == userData.length,
                      );
                    },
                  ).toList(),
                  RoundedButton(
                    text: 'edit',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => UpdateAccountScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 3,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 80,
                backgroundColor: AppColors.backgroundLight,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(80),
                  child: CircleAvatar(
                    radius: 70,
                    child: SizedBox(
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/Male.png',
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _createRowItem({
    required String title,
    required IconData icon,
    required bool isLastRow,
  }) {
    return Column(
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
            ],
          ),
        ),
        if (!isLastRow)
          const Divider(
            height: 1,
          ),
      ],
    );
  }
}

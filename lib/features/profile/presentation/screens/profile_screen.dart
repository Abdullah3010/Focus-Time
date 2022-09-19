import 'package:flutter/material.dart';
import 'package:focus_time/core/user/current_user.dart';
import 'package:focus_time/core/utils/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = CurrentUser.get();
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "${user!.firstName} ${user.lastName}",
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 20,
                ),
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
                  children: [
                    _getRowDetails(
                      fieldName: 'Email',
                      fieldDetails: user.email,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    _getRowDetails(
                      fieldName: 'Phone',
                      fieldDetails: user.phone,
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    _getRowDetails(
                      fieldName: 'Birthdate',
                      fieldDetails: user.birthdate.toDate().toUtc().toString(),
                    ),
                    const Divider(
                      height: 20,
                      thickness: 2,
                    ),
                    _getRowDetails(
                      fieldName: 'Gender',
                      fieldDetails: user.gender,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _getRowDetails({
    required String fieldName,
    required String fieldDetails,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            fieldName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Text(
              fieldDetails,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class DetailsListItem {
  final Widget? route;
  final String title;
  final IconData icon;
  final Function? onTap;

  DetailsListItem({
    required this.title,
    required this.icon,
    this.route,
    this.onTap,
  });
}

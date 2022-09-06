import 'package:flutter/material.dart';

class SocialIcon extends StatelessWidget {
  final IconData icon;
  final Color color;
  final Function() onPressed;

  const SocialIcon({
    required this.icon,
    required this.color,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(icon),
      iconSize: 50,
      color: color,
      splashRadius: 27,
      splashColor: color.withOpacity(0.3),
      onPressed: onPressed,
    );
  }
}

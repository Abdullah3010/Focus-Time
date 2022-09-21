import 'package:flutter/material.dart';
import 'package:focus_time/core/utils/app_colors.dart';

class RoundedButton extends StatelessWidget {
  final Widget? child;
  final String? text;
  final Function onPressed;
  final EdgeInsetsGeometry? padding;
  final double width;
  final double height;

  const RoundedButton({
    required this.onPressed,
    this.child,
    this.text = 'Test Button',
    this.padding = const EdgeInsets.symmetric(vertical: 12, horizontal: 30),
    this.width = 120,
    this.height = 40,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      color: AppColors.primary,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(3),
          bottomRight: Radius.circular(3),
          bottomLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      elevation: 5,
      onPressed: () {
        onPressed();
      },
      child: Container(
        width: width,
        height: height,
        child: Center(
          child: child ??
              Text(
                text!.toUpperCase(),
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
        ),
      ),
    );
  }
}

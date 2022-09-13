import 'package:flutter/material.dart';

class StretchScrollWidget extends StatelessWidget {
  final Widget child;

  const StretchScrollWidget({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
      child: StretchingOverscrollIndicator(
        axisDirection: AxisDirection.down,
        child: child,
      ),
    );
  }
}

import 'package:flutter/material.dart';

class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xffF8F7F5),
            Color(0xffF9EDDF),
            Color(0xffF9EDDF),
            Color(0xffF9E8D5),
          ],
        ),
      ),
      child: child,
    );
  }
}
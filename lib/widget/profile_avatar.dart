import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/home.dart';

class ProfileAvatar extends StatelessWidget {
  const ProfileAvatar({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<HomeModel>().animationProgress;
    final scale = (progress / 0.1).clamp(0.0, 1.0);

    return Transform.scale(
      scale: scale,
      child: CircleAvatar(
        radius: 20.r,
        backgroundImage: const AssetImage('assets/images/portrait.jpeg'),
      ),
    );
  }
}

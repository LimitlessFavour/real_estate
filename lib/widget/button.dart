import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/app/theme.dart';

class ActionButton extends StatelessWidget {
  const ActionButton({
    super.key,
    required this.icon,
    this.onPressed,
    this.color,
  });

  final Widget icon;
  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    Widget child = Padding(
      padding: EdgeInsets.all(12.w),
      child: icon,
    );

    return Center(
      child: Container(
        decoration: BoxDecoration(
          color: color ?? theme.colorScheme.surface,
          shape: BoxShape.circle,
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            customBorder: const CircleBorder(),
            onTap: onPressed,
            child: child,
          ),
        ),
      ),
    );
  }
}

class VariantsButton extends StatelessWidget {
  const VariantsButton({
    super.key,
    this.onPressed,
    this.color,
  });

  final VoidCallback? onPressed;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Positioned(
      right: 24.w,
      bottom: 84.h,
      child: Container(
        decoration: BoxDecoration(
          color: color ?? AppTheme.grey,
          borderRadius: BorderRadius.circular(24.r),
        ),
        child: Material(
          type: MaterialType.transparency,
          child: InkWell(
            borderRadius: BorderRadius.circular(24.r),
            onTap: onPressed ?? () {},
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIcons.zoomSvg(
                    width: 18,
                    height: 18,
                    color: Colors.white,
                  ),
                  Gap(4.w),
                  Text(
                    'List of Variants',
                    style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500, color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

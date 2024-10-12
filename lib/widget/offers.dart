import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/home.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<HomeModel>().animationProgress;
    final entranceProgress = ((progress - 0.3) / 0.07).clamp(0.0, 1.0);
    final countProgress = ((progress - 0.3) / 0.14).clamp(0.0, 1.0);

    return Transform.translate(
      offset: Offset(0, 50 * (1 - entranceProgress)),
      child: Opacity(
        opacity: entranceProgress,
        child: Row(
          children: [
            Expanded(
              child: OfferCard(
                type: 'BUY',
                count: 1034,
                isSelected: true,
                animationProgress: countProgress,
              ),
            ),
            Gap(12.w),
            Expanded(
              child: OfferCard(
                type: 'RENT',
                count: 2212,
                isSelected: false,
                animationProgress: countProgress,
              ),
            ),
            Gap(6.w),
          ],
        ),
      ),
    );
  }
}

class OfferCard extends StatelessWidget {
  final String type;
  final int count;
  final bool isSelected;
  final double animationProgress;

  const OfferCard({
    super.key,
    required this.type,
    required this.count,
    required this.isSelected,
    required this.animationProgress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buy = type == 'BUY';
    final animatedCount = (count * animationProgress).round();
    final scale = 1 + (animationProgress * 0.1);

    return Transform.scale(
      scale: scale,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? theme.colorScheme.primary : Colors.white,
          borderRadius: buy ? null : BorderRadius.circular(16.r),
          shape: buy ? BoxShape.circle : BoxShape.rectangle,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              type,
              style: theme.textTheme.labelSmall!.copyWith(
                color: isSelected ? Colors.white : theme.colorScheme.secondary,
              ),
            ),
            Gap(16.h),
            Text(
              animatedCount.toString(),
              style: theme.textTheme.displaySmall!.copyWith(
                color: isSelected ? Colors.white : theme.colorScheme.secondary,
              ),
            ),
            Text(
              'offers',
              style: theme.textTheme.labelSmall!.copyWith(
                color: isSelected
                    ? Colors.white.withOpacity(0.7)
                    : theme.colorScheme.secondary,
              ),
            ),
            Gap(8.h),
          ],
        ),
      ),
    );
  }
}

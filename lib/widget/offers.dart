import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(
          child: OfferCard(
            type: 'BUY',
            count: 1034,
            isSelected: true,
          ),
        ),
        // Gap(4.w),
        Expanded(
          child: OfferCard(
            type: 'RENT',
            count: 2212,
            isSelected: false,
          ),
        ),
      ],
    );
  }
}

class OfferCard extends StatelessWidget {
  final String type;
  final int count;
  final bool isSelected;

  const OfferCard({
    super.key,
    required this.type,
    required this.count,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final buy = type == 'BUY';
    return Container(
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
            count.toString(),
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
    );
  }
}

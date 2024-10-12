import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class OffersSection extends StatelessWidget {
  const OffersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(
          child: OfferCard(
            type: 'BUY',
            count: 1034,
            isSelected: true,
          ),
        ),
        // Gap(4.w),
        const Expanded(
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
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
              color: isSelected ? Colors.white : theme.colorScheme.secondary,
            ),
          ),
          Gap(16.h),
          Text(
            count.toString(),
            style: GoogleFonts.inter(
              fontSize: 24.sp,
              fontWeight: FontWeight.bold,
              color: isSelected ? Colors.white : theme.colorScheme.secondary,
            ),
          ),
          // Gap(4.h),
          Text(
            'offers',
            style: GoogleFonts.inter(
              fontSize: 10.sp,
              fontWeight: FontWeight.w500,
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

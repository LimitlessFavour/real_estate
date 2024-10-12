import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/widget/gradient_background.dart';
import 'package:real_estate/widget/offers.dart';
import 'package:real_estate/widget/profile_avatar.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/widget/properties_sheet.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.all(16.0.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      LocationChip(),
                      ProfileAvatar(),
                    ],
                  ),
                  Gap(32.h),
                  const IntroText(),
                  Gap(24.h),
                  const OffersSection(),
                  Gap(24.h),
                ],
              ),
            ),
          ),
          const PropertiesSheet(properties: dummyProperties),
        ],
      ),
    );
  }
}

class IntroText extends StatelessWidget {
  const IntroText({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Hi, Marina', style: theme.textTheme.titleLarge),
        Gap(6.h),
        Text(
          "let's select your\nperfect place",
          style: theme.textTheme.displayMedium,
        ),
      ],
    );
  }
}

class LocationChip extends StatelessWidget {
  const LocationChip({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          CustomIcons.locationSvg(
            width: 16.w,
            height: 16.h,
            color: theme.colorScheme.secondary,
          ),
          Gap(4.w),
          Text(
            'Saint Petersburg',
            style: theme.textTheme.labelLarge?.copyWith(
              color: theme.colorScheme.secondary,
              fontWeight: FontWeight.w400,
            ),
          ),
        ],
      ),
    );
  }
}

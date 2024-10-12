import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/home.dart';
import 'package:real_estate/widget/gradient_background.dart';
import 'package:real_estate/widget/offers.dart';
import 'package:real_estate/widget/profile_avatar.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/widget/properties_sheet.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeModel>().animateEntrance();
    });
  }

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
    final progress = context.watch<HomeModel>().animationProgress;
    final animationProgress = ((progress - 0.1) / 0.1).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Transform.translate(
          offset: Offset(0, 20 * (1 - animationProgress)),
          child: Opacity(
            opacity: animationProgress,
            child: Text('Hi, Marina', style: theme.textTheme.titleLarge),
          ),
        ),
        Gap(6.h),
        Transform.translate(
          offset: Offset(0, 20 * (1 - animationProgress)),
          child: Opacity(
            opacity: animationProgress,
            child: Text(
              "let's select your\nperfect place",
              style: theme.textTheme.displayMedium,
            ),
          ),
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
    final progress = context.watch<HomeModel>().animationProgress;
    final animationProgress = (progress / 0.1).clamp(0.0, 1.0);
    final containerWidth = 150.w * animationProgress;
    final textOpacity = ((animationProgress - 0.5) * 2).clamp(0.0, 1.0);

    return Container(
      width: containerWidth,
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
          Expanded(
            child: Opacity(
              opacity: textOpacity,
              child: Text(
                'Saint Petersburg',
                maxLines: 1,
                
                style: theme.textTheme.labelLarge?.copyWith(
                  color: theme.colorScheme.secondary,
                  fontWeight: FontWeight.w400,
                  fontSize: 12.sp,
                ),
                overflow: TextOverflow.clip,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:gap/gap.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:real_estate/widget/gradient_background.dart';
import 'package:real_estate/widget/offers.dart';
import 'package:real_estate/widget/profile_avatar.dart';
import 'package:real_estate/app/icons.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.0.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
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
              const PropertiesSheet(),
            ],
          ),
        ),
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
        Text(
          'Hi, Marina',
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.colorScheme.secondary,
            fontWeight: FontWeight.w500,
          ),
        ),
        Gap(6.h),
        Text(
          "let's select your\nperfect place",
          style: theme.textTheme.displayLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w500,
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

class PropertiesSheet extends StatelessWidget {
  const PropertiesSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const PropertyCard(
          image: 'assets/images/property1.jpeg',
          address: 'Gladkova St., 25',
        ),
        Gap(16.h),
        Row(
          children: [
            const Expanded(
              child: PropertyCard(
                image: 'assets/images/property2.jpeg',
                address: '',
                small: true,
              ),
            ),
            Gap(16.h),
            const Expanded(
              child: PropertyCard(
                image: 'assets/images/property3.jpeg',
                address: 'Trefoleva St., 43',
                small: true,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class PropertyCard extends StatelessWidget {
  final String image;
  final String address;
  final bool small;

  const PropertyCard({
    super.key,
    required this.image,
    required this.address,
    this.small = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: small ? 120.h : 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          if (address.isNotEmpty)
            Positioned(
              left: 16.w,
              bottom: 16.h,
              child: Row(
                children: [
                  Text(
                    address,
                    style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Gap(4.w),
                  CustomIcons.rightSvg(
                    width: 16.w,
                    height: 16.h,
                    color: Colors.white,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

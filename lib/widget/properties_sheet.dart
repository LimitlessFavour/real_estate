import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/models/property.dart';

class PropertiesSheet extends StatelessWidget {
  final List<Property> properties;

  const PropertiesSheet({
    super.key,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {


    return AnimatedPositioned(
      duration: const Duration(milliseconds: 300),
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: 0.6.sh,
        width: double.infinity,
        padding: EdgeInsets.only(
          top: 8.w,
          left: 8.w,
          right: 8.w,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.horizontal(
            left: Radius.circular(16.r),
            right: Radius.circular(16.r),
          ),
        ),
        child: Column(
          children: [
            if (properties.isNotEmpty)
              PropertyCard(
                image: properties[0].imagePath,
                address: properties[0].address,
              ),
            Gap(16.h),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 16.h,
                crossAxisSpacing: 16.w,
                childAspectRatio: 1.5,
                children: properties.skip(1).map((property) {
                  return PropertyCard(
                    image: property.imagePath,
                    address: property.address,
                    small: true,
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
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
    final theme = Theme.of(context);
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
                    style: theme.textTheme.labelLarge?.copyWith(
                      color: Colors.white,
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

const List<Property> dummyProperties = [
  Property(imagePath: 'assets/images/property1.jpeg', address: 'Gladkova St., 25'),
  Property(imagePath: 'assets/images/property2.jpeg', address: 'Nevsky Prospekt, 78'),
  Property(imagePath: 'assets/images/property3.jpeg', address: 'Trefoleva St., 43'),
  Property(imagePath: 'assets/images/property4.jpeg', address: 'Bolshaya Morskaya St., 12'),
];
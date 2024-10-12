import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/app/icons.dart';
import 'package:real_estate/app/theme.dart';
import 'package:real_estate/models/home.dart';
import 'package:real_estate/models/property.dart';
import 'package:latlong2/latlong.dart';
import 'dart:ui';

class PropertiesSheet extends StatelessWidget {
  final List<Property> properties;

  const PropertiesSheet({
    super.key,
    required this.properties,
  });

  @override
  Widget build(BuildContext context) {
    final progress = context.watch<HomeModel>().animationProgress;
    final sheetProgress = ((progress - 0.44) / 0.1).clamp(0.0, 1.0);

    return AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
      bottom: -0.6.sh * (1 - sheetProgress),
      left: 0,
      right: 0,
      child: Container(
        height: 0.6.sh,
        width: double.infinity,
        padding: EdgeInsets.all(8.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
        ),
        child: Column(
          children: [
            if (properties.isNotEmpty)
              PropertyCard(
                image: properties[0].imagePath,
                address: properties[0].address,
                size: PropertyCardSize.large,
                index: 0,
              ),
            Gap(8.h),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: PropertyCard(
                      image: properties[1].imagePath,
                      address: properties[1].address,
                      size: PropertyCardSize.medium,
                      index: 1,
                    ),
                  ),
                  Gap(8.w),
                  Expanded(
                    child: Column(
                      children: [
                        PropertyCard(
                          image: properties[2].imagePath,
                          address: properties[2].address,
                          size: PropertyCardSize.small,
                          index: 2,
                        ),
                        Gap(8.h),
                        PropertyCard(
                          image: properties[3].imagePath,
                          address: properties[3].address,
                          size: PropertyCardSize.small,
                          index: 3,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum PropertyCardSize { small, medium, large }

class PropertyCard extends StatelessWidget {
  final String image;
  final String address;
  final PropertyCardSize size;
  final int index;

  const PropertyCard({
    super.key,
    required this.image,
    required this.address,
    required this.size,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final progress = context.watch<HomeModel>().animationProgress;
    final cardProgress =
        ((progress - (0.54 + index * 0.03)) / 0.06).clamp(0.0, 1.0);

    return Container(
      height: _getHeight(),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            left: 10.w,
            right: 10.w,
            bottom: 10.h,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(32.r),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Colors.white.withOpacity(0.5),
                        Colors.white.withOpacity(0.3),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(32.r),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.2),
                      width: 1.5,
                    ),
                  ),
                  child: LayoutBuilder(
                    builder: (context, constraints) {
                      final maxWidth = constraints.maxWidth;
                      return Stack(
                        children: [
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 1000),
                            width: maxWidth * cardProgress,
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 16.w,
                                      vertical: 8.h,
                                    ),
                                    child: Text(
                                      address,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style:
                                          theme.textTheme.labelLarge?.copyWith(
                                        color: AppTheme.fontColor,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 12.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            right: maxWidth * (1 - cardProgress),
                            top: 0,
                            bottom: 0,
                            child: Center(
                              child: Container(
                                padding: EdgeInsets.all(10.w),
                                margin: EdgeInsets.all(2.w),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                  shape: BoxShape.circle,
                                ),
                                child: CustomIcons.arrowRightSvg(
                                  width: 10.w,
                                  height: 10.h,
                                  color: AppTheme.grey,
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _getHeight() {
    switch (size) {
      case PropertyCardSize.small:
        return 94.h;
      case PropertyCardSize.medium:
        return 200.h;
      case PropertyCardSize.large:
        return 150.h;
    }
  }
}

const List<Property> dummyProperties = [
  Property(
      imagePath: 'assets/images/property1.jpeg',
      address: 'Gladkova St., 25',
      isCozy: true,
      price: 250000,
      infrastructureType: InfrastructureType.house,
      location: LatLng(59.9352802, 30.3360986)),
  Property(
      imagePath: 'assets/images/property2.jpeg',
      address: 'Nevsky Prospekt, 78',
      isCozy: false,
      price: 500000,
      infrastructureType: InfrastructureType.hotel,
      location: LatLng(59.9332802, 30.3340986)),
  Property(
      imagePath: 'assets/images/property3.jpeg',
      address: 'Trefoleva St., 43',
      isCozy: true,
      price: 180000,
      infrastructureType: InfrastructureType.apartment,
      location: LatLng(59.9362802, 30.3370986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Bolshaya Morskaya St., 12',
      isCozy: false,
      price: 750000,
      infrastructureType: InfrastructureType.office,
      location: LatLng(59.9322802, 30.3330986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Liteyny Prospekt, 59',
      isCozy: true,
      price: 320000,
      infrastructureType: InfrastructureType.house,
      location: LatLng(59.9372802, 30.3380986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Kamennoostrovsky Prospekt, 37',
      isCozy: false,
      price: 1200000,
      infrastructureType: InfrastructureType.villa,
      location: LatLng(59.9312802, 30.3320986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Gorokhovaya St., 64',
      isCozy: true,
      price: 210000,
      infrastructureType: InfrastructureType.apartment,
      location: LatLng(59.9382802, 30.3390986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Fontanka River Embankment, 90',
      isCozy: false,
      price: 450000,
      infrastructureType: InfrastructureType.hotel,
      location: LatLng(59.9302802, 30.3310986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Marata St., 22',
      isCozy: true,
      price: 280000,
      infrastructureType: InfrastructureType.house,
      location: LatLng(59.9392802, 30.3400986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Sadovaya St., 55',
      isCozy: false,
      price: 390000,
      infrastructureType: InfrastructureType.office,
      location: LatLng(59.9292802, 30.3300986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Petrogradskaya Embankment, 8',
      isCozy: true,
      price: 850000,
      infrastructureType: InfrastructureType.villa,
      location: LatLng(59.9402802, 30.3410986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Moskovsky Prospekt, 130',
      isCozy: false,
      price: 420000,
      infrastructureType: InfrastructureType.hotel,
      location: LatLng(59.9282802, 30.3290986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Ligovsky Prospekt, 72',
      isCozy: true,
      price: 195000,
      infrastructureType: InfrastructureType.apartment,
      location: LatLng(59.9412802, 30.3420986)),
  Property(
      imagePath: 'assets/images/property4.jpeg',
      address: 'Vasilyevsky Island, 7th Line, 34',
      isCozy: false,
      price: 560000,
      infrastructureType: InfrastructureType.office,
      location: LatLng(59.9272802, 30.3280986)),
];

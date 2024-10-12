import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/app/icons.dart';
import '../models/property.dart';

class PropertyMarker extends StatelessWidget {
  final Property property;

  const PropertyMarker({super.key, required this.property});

  @override
  Widget build(BuildContext context) {
    final radius = Radius.circular(8.r);
    return Consumer<PropertyFilter>(
      builder: (context, propertyFilter, _) {
        final markerDisplay = propertyFilter.markerDisplay;

        Widget markerContent;
        switch (markerDisplay) {
          case PropertyMarkerDisplay.price:
            markerContent = Text(
              '\$${property.price.toStringAsFixed(0)}',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            );
            break;
          case PropertyMarkerDisplay.infrastructure:
            markerContent = CustomIcons.buildingSvg(
              color: Colors.white,
              width: 20,
              height: 20,
            );
            break;
          case PropertyMarkerDisplay.none:
          default:
            markerContent = CustomIcons.buildingSvg(
              color: Colors.white,
              width: 20,
              height: 20,
            );
        }

        return GestureDetector(
          onTap: () {
            // Handle marker tap
          },
          child: Container(
            padding: EdgeInsets.all(8.h),
            decoration: BoxDecoration(
              color: Colors.orange,
              borderRadius: BorderRadius.only(
                topLeft: radius,
                topRight: radius,
                bottomRight: radius,
              ),
            ),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: markerContent,
            ),
          ),
        );
      },
    );
  }
}

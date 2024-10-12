// ignore_for_file: type_annotate_public_apis

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/widget/properties_sheet.dart';
import 'dart:math';

import 'package:real_estate/widget/property_marker.dart';

class AppMap extends StatefulWidget {
  const AppMap({
    Key? key,
    this.addBorderRadius = false,
  }) : super(key: key);

  final bool addBorderRadius;

  @override
  State<AppMap> createState() => _AppMapState();
}

class _AppMapState extends State<AppMap>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<AppMap> {
  var darkMode = true;

  late final MapController _mapController;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    _placedMarkers.clear(); // Clear the list before rebuilding
    super.build(context);
    return Consumer<PropertyFilter>(
      builder: (context, propertyFilter, _) {
        final filteredProperties =
            propertyFilter.filterProperties(dummyProperties);
        return Stack(
          children: [
            FlutterMap(
              mapController: _mapController,
              options: const MapOptions(
                initialCenter: LatLng(
                  59.9342802,
                  30.3350986,
                ), // Center the map over St. Petersburg
                initialZoom: 12,
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                  minNativeZoom: 6,
                  maxNativeZoom: 11,
                  tileBuilder: _darkModeTileBuilder,
                ),
                const RichAttributionWidget(
                  attributions: [
                    TextSourceAttribution('OpenStreetMap contributors'),
                    TextSourceAttribution('CartoDB'),
                  ],
                ),
              ],
            ),
            ...List.generate(filteredProperties.length, (index) {
              return _buildMarker(
                filteredProperties[index],
                MediaQuery.of(context).size,
                index,
                filteredProperties.length,
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildMarker(Property property, Size size, int index, int total) {
    final random = Random(property.hashCode); // Use property hash as seed for consistency
    final double maxRadius = 0.48 * min(size.width, size.height);
    final double minRadius = 0.1 * maxRadius; // Minimum distance from center

    double left, top;
    bool validPosition;
    int attempts = 0;

    do {
      // Generate random angle and radius
      final double angle = random.nextDouble() * 2 * pi;
      final double radius = minRadius + random.nextDouble() * (maxRadius - minRadius);

      left = size.width / 2 + radius * cos(angle);
      top = size.height / 2 + radius * sin(angle);

      // Check if the position is valid (not too close to other markers)
      validPosition = _isValidPosition(left, top, size);
      attempts++;
    } while (!validPosition && attempts < 50); // Limit attempts to avoid infinite loop

    return Consumer<SearchModel>(
      builder: (context, searchModel, _) {
        final markerProgress =
            (searchModel.animationProgress - 0.5).clamp(0.0, 0.5) * 2;
        final scale = 0.5 + (0.5 * markerProgress);
        final opacity = markerProgress;

        return Positioned(
          left: left - 15,
          top: top - 15,
          child: Opacity(
            opacity: opacity,
            child: Transform.scale(
              scale: scale,
              child: PropertyMarker(property: property),
            ),
          ),
        );
      },
    );
  }

  // Add this method to check if a position is valid
  bool _isValidPosition(double left, double top, Size size) {
    const minDistance = 60.0; // Minimum distance between markers
    for (var marker in _placedMarkers) {
      double distance = sqrt(pow(left - marker.dx, 2) + pow(top - marker.dy, 2));
      if (distance < minDistance) {
        return false;
      }
    }
    _placedMarkers.add(Offset(left, top));
    return true;
  }

  // Add this list to keep track of placed markers
  final List<Offset> _placedMarkers = [];
}

Widget _darkModeTileBuilder(
  BuildContext context,
  Widget tileWidget,
  TileImage tile,
) {
  return ColorFiltered(
    colorFilter: const ColorFilter.matrix(<double>[
      -0.2126, -0.7152, -0.0722, 0, 255, // Red channel
      -0.2126, -0.7152, -0.0722, 0, 255, // Green channel
      -0.2126, -0.7152, -0.0722, 0, 255, // Blue channel
      0, 0, 0, 1, 0, // Alpha channel
    ]),
    child: tileWidget,
  );
}

// ignore_for_file: type_annotate_public_apis

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:provider/provider.dart';
import 'package:real_estate/models/property.dart';
import 'package:real_estate/widget/properties_sheet.dart';

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
  late List<Marker> markers;

  late final StreamSubscription<MapEvent> subscription;
  int flags = InteractiveFlag.drag |
      InteractiveFlag.pinchZoom |
      InteractiveFlag.doubleTapZoom |
      InteractiveFlag.flingAnimation |
      InteractiveFlag.rotate;

  @override
  void initState() {
    super.initState();
    _mapController = MapController();
    subscription = _mapController.mapEventStream.listen(onMapEvent);
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  void onMapEvent(MapEvent mapEvent) {
    if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
      // do not flood console with move and rotate events
      // print(mapEvent);
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final theme = Theme.of(context);

    return Consumer<PropertyFilter>(
      builder: (context, propertyFilter, _) {
        final filteredProperties =
            propertyFilter.filterProperties(dummyProperties);
        markers = filteredProperties
            .map((property) => buildMarker(property))
            .toList();
        return FlutterMap(
          options: MapOptions(
            initialCenter: const LatLng(
                59.9342802, 30.3350986), // Center the map over St. Petersburg
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
            // MarkerLayer(
            //   markers: markers,
            // ),
          ],
        );
      },
    );
  }
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

Marker buildMarker(Property property) {
  return Marker(
    point: property.location,
    height: 30,
    width: 60,
    // child: PropertyMarker(property: property),
    child: const Icon(Icons.location_pin, size: 60, color: Colors.black),
  );
}

class PropertyMarker extends StatelessWidget {
  const PropertyMarker({
    super.key,
    required this.property,
  });

  final Property property;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: () {
        // Handle marker tap
      },
      child: FlutterLogo(
          // color: theme.colorScheme.secondary,
          // child: Text(),
          ),
    );
  }
}

Widget markerPopupBuilder(BuildContext context, Marker marker) {
  // Implement the popup builder
  return const SizedBox.shrink();
}

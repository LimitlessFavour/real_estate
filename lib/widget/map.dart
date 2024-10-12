// // ignore_for_file: type_annotate_public_apis

// import 'dart:async';

// import 'package:flutter/material.dart' hide Theme;
// import 'package:flutter_map/flutter_map.dart';
// import 'package:flutter_map/plugin_api.dart';
// import 'package:flutter_map_marker_cluster/flutter_map_marker_cluster.dart';
// import 'package:latlong2/latlong.dart';
// import 'package:shared/shared.dart';
// import 'package:provider/provider.dart';
// import 'package:sturrd/app/app.dart';
// import 'package:sturrd/app/environment/config_reader.dart';
// import 'package:sturrd/app/widgets/avatar.dart';
// import 'package:sturrd/locations/widgets/map/marker_popup.dart';
// import 'package:sturrd/locations/widgets/map/markers.dart';
// import 'package:sturrd/locations/widgets/map/model.dart';
// import 'package:sturrd/locations/widgets/map/zoombuttons_plugin_option.dart';
// import 'package:sturrd/locations/widgets/ripples.dart';
// import 'package:sturrd/notifications/cubits/notification_actions.dart';
// import 'package:sturrd_design_system/sturrd_design_system.dart';
// // import 'package:vector_map_tiles/vector_map_tiles.dart';
// // import 'package:vector_tile_renderer/vector_tile_renderer.dart';

// class AppMap<T> extends StatefulWidget {
//   const AppMap({
//     Key? key,
//     this.elements = const [],
//     required this.currentLocation,
//     this.addBorderRadius = false,
//     this.liveLocation,
//   }) : super(key: key);

//   final List<T> elements;
//   final bool addBorderRadius;
//   final Location currentLocation;
//   final Stream<Location>? liveLocation;
//   @override
//   State<AppMap> createState() => _AppMapState<T>();
// }

// // class _AppMapState extends State<AppMap>{
// class _AppMapState<T> extends State<AppMap<T>>
//     with TickerProviderStateMixin, AutomaticKeepAliveClientMixin<AppMap<T>> {
//   //TODO: Set to true if having map errors.
//   bool _needLoadingError = false;
//   var darkMode = true;

//   late Location currentLocation;
//   late final MapController _mapController;
//   late final PopupController _popupController;
//   late final double _initialZoom;
//   late final List<Marker> markers;
//   late final List<T> elements;

//   late final StreamSubscription<MapEvent> subscription;
//   int flags = InteractiveFlag.drag |
//       InteractiveFlag.pinchZoom |
//       InteractiveFlag.doubleTapZoom |
//       InteractiveFlag.flingAnimation |
//       InteractiveFlag.rotate;

//   @override
//   void initState() {
//     super.initState();
//     _mapController = MapController();
//     _popupController = PopupController();
//     subscription = _mapController.mapEventStream.listen(onMapEvent);
//     _initialZoom = 12.0;
//     _synchronizeLocation();
//     _setupMarkers();
//   }

//   @override
//   void dispose() {
//     subscription.cancel();
//     super.dispose();
//   }

//   void _setupMarkers() {
//     elements = widget.elements;
//     markers = elements.map(buildMarker).toList();
//   }

//   void _synchronizeLocation() {
//     currentLocation = widget.currentLocation;
//     if (widget.liveLocation != null) {
//       widget.liveLocation!.listen((Location location) async {
//         if (mounted && currentLocation.latLng != null) {
//           setState(() {
//             currentLocation = location;
//             // If Live Update is enabled, move map center
//             _mapController.move(
//               currentLocation.latLng!,
//               _mapController.zoom,
//             );
//           });
//         }
//       });
//     }
//   }

//   void onMapEvent(MapEvent mapEvent) {
//     if (mapEvent is! MapEventMove && mapEvent is! MapEventRotate) {
//       // do not flood console with move and rotate events
//       // print(mapEvent);
//     }
//   }

//   void _animatedMapMove(LatLng destLocation, double destZoom) {
//     final latTween = Tween<double>(
//         begin: _mapController.center.latitude, end: destLocation.latitude);
//     final lngTween = Tween<double>(
//         begin: _mapController.center.longitude, end: destLocation.longitude);
//     final zoomTween = Tween<double>(begin: _mapController.zoom, end: destZoom);

//     final controller = AnimationController(
//       duration: const Duration(milliseconds: 500),
//       vsync: this,
//     );
//     final Animation<double> animation =
//         CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

//     controller.addListener(() {
//       _mapController.move(
//           LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
//           zoomTween.evaluate(animation));
//     });

//     animation.addStatusListener((status) {
//       if (status == AnimationStatus.completed) {
//         controller.dispose();
//       } else if (status == AnimationStatus.dismissed) {
//         controller.dispose();
//       }
//     });

//     controller.forward();
//   }

//   @override
//   bool get wantKeepAlive => true;

//   @override
//   Widget build(BuildContext context) {
//     super.build(context);
//     final centerPoint = currentLocation.latLng!;
//     final theme = context.theme;
//     final themeMode = context.read<AppBloc>().state.themeMode;
//     darkMode = AppResponsiveTheme.colorModeOf(context, themeMode) ==
//         AppThemeColorMode.dark;
//     final style = darkMode ? 'dark-v10' : 'streets-v11';

//     // return ChangeNotifierProvider<MapModel>(
//     //     create: (_) => MapModel()..load(darkMode),
//     //     builder: (context, _) {
//     //       return Consumer<MapModel>(builder: (context, model, _) {
//     //         if (model.loading) {
//     //           return const Center(
//     //             child: CommonProgressIndicator.fast(
//     //               indicatorSize: ProgressIndicatorSize.small,
//     //             ),
//     //           );
//     //         } else if (model.theme == null) {
//     //           print('omo, map error don occur');
//     //           return const SizedBox.shrink();
//     //         }
//     return ClipRRect(
//       borderRadius: widget.addBorderRadius
//           ? context.theme.radius.asBorderRadius().mini
//           : BorderRadius.zero,
//       child: FlutterMap(
//         mapController: _mapController,
//         options: MapOptions(
//           center: centerPoint,
//           interactiveFlags: flags,

//           //TODO: ADJUST ZOOM to match normal user view
//           // minZoom: 12.0,
//           // maxZoom: 14.0,
//           // zoom: 13.0,
//           // zoom: 16,

//           onTap: (_, __) {
//             _popupController.hideAllPopups();
//           },
//           zoom: _initialZoom,
//         ),
//         nonRotatedChildren: [
//           FlutterMapZoomButtons(
//             minZoom: 4,
//             maxZoom: 19,
//             initialZoom: _initialZoom,
//             animatedMapMove: _animatedMapMove,
//             currentPosition: centerPoint,
//             padding: 10,
//             alignment: const Alignment(0.9, -0.8),
//           ),
//         ],
//         children: [
//           // VectorTileLayer(
//           //   theme: model.theme!,
//           //   backgroundTheme: model.theme!.copyWith(types: {
//           //     ThemeLayerType.background,
//           //     ThemeLayerType.fill
//           //   }),
//           //   tileOffset: TileOffset.mapbox,
//           //   tileProviders: TileProviders(
//           //     {'composite': model.tileProvider()},
//           //   ),
//           // ),
//           TileLayer(
//             urlTemplate:
//                 'https://api.mapbox.com/styles/v1/mapbox/$style/tiles/512/{z}/{x}/{y}?access_token={accessToken}',
//             // ignore: lines_longer_than_80_chars
//             tileProvider: NetworkTileProvider(),

//             additionalOptions: {
//               'accessToken': ConfigReader.mapAccessToken,
//             },
//             subdomains: const ['a', 'b', 'c'],
//             backgroundColor:
//                 context.theme.colors.secondary400, //color for unloaded part.
//             errorTileCallback: (TileImage tile, _, dynamic error) {
//               if (_needLoadingError) {
//                 WidgetsBinding.instance.addPostFrameCallback((_) {
//                   showElegantNotification(
//                     ElegantNotificationType.failure,
//                     context: context,
//                     title: error.toString(),
//                     subtitle: '',
//                   );
//                 });
//                 _needLoadingError = false;
//               }
//             },
//           ),
//           MarkerLayer(
//             markers: [
//               ...markers,
//               //currentUser marker
//               Marker(
//                 point: centerPoint,
//                 height: 80,
//                 width: 80,
//                 builder: (context) => const CurrentUserMarker(),
//               ),
//             ],
//           ),
//           MarkerClusterLayerWidget(
//             options: MarkerClusterLayerOptions(
//               maxClusterRadius: 120,
//               size: const Size(40, 40),
//               fitBoundsOptions: const FitBoundsOptions(
//                 padding: EdgeInsets.all(50),
//               ),
//               markers: markers,
//               polygonOptions: PolygonOptions(
//                 borderColor: theme.colors.primary700,
//                 color: Colors.black12,
//                 borderStrokeWidth: 2,
//               ),
//               popupOptions: PopupOptions(
//                 // popupState: PopupState(),
//                 popupController: _popupController,
//                 popupSnap: PopupSnap.markerBottom,
//                 popupBuilder: markerPopupBuilder,
//                 popupAnimation: PopupAnimation.fade(
//                   // ignore: avoid_redundant_argument_values
//                   curve: Curves.ease,
//                   duration: context.theme.durations.regular,
//                 ),
//                 // ignore: avoid_redundant_argument_values
//                 markerRotate: false,
//                 markerTapBehavior: MarkerTapBehavior.togglePopupAndHideRest(),
//               ),
//               builder: (context, markers) {
//                 return FloatingActionButton(
//                   onPressed: null,
//                   backgroundColor: theme.colors.primary700,
//                   child: AppText.paragraph2(
//                     markers.length.toString(),
//                     color: theme.colors.white,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//     //   });
//     // });
//   }
// }

import 'package:flutter/material.dart';

class AppMap extends StatelessWidget {
  const AppMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black54,
    );
  }
}

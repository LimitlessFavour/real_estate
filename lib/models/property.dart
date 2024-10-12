import 'package:flutter/foundation.dart';
import 'package:latlong2/latlong.dart';

enum PropertyMarkerDisplay { price, infrastructure, none }
enum InfrastructureType { house, hotel, apartment, office, villa }

class Property {
  final String imagePath;
  final String address;
  final bool isCozy;
  final double price;
  final InfrastructureType infrastructureType;
  final LatLng location;

  const Property({
    required this.imagePath,
    required this.address,
    this.isCozy = false,
    required this.price,
    required this.infrastructureType,
    required this.location,
  });
}

class PropertyFilter extends ChangeNotifier {
  bool _showCozyOnly = false;
  double _maxPrice = double.infinity;
  final Set<InfrastructureType> _selectedTypes =
      Set<InfrastructureType>.from(InfrastructureType.values);
  PropertyMarkerDisplay _markerDisplay = PropertyMarkerDisplay.none;

  bool get showCozyOnly => _showCozyOnly;
  double get maxPrice => _maxPrice;
  Set<InfrastructureType> get selectedTypes => _selectedTypes;
  PropertyMarkerDisplay get markerDisplay => _markerDisplay;

  void setShowCozyOnly(bool value) {
    if (_showCozyOnly != value) {
      _showCozyOnly = value;
      notifyListeners();
    }
  }

  void setMaxPrice(double value) {
    if (_maxPrice != value) {
      _maxPrice = value;
      notifyListeners();
    }
  }

  void toggleInfrastructureType(InfrastructureType type) {
    if (_selectedTypes.contains(type)) {
      _selectedTypes.remove(type);
    } else {
      _selectedTypes.add(type);
    }
    notifyListeners();
  }

  void setMarkerDisplay(PropertyMarkerDisplay display) {
    if (_markerDisplay != display) {
      _markerDisplay = display;
      notifyListeners();
    }
  }

  List<Property> filterProperties(List<Property> properties) {
    return properties.where((property) {
      return (!_showCozyOnly || property.isCozy) &&
          property.price <= _maxPrice &&
          _selectedTypes.contains(property.infrastructureType);
    }).toList();
  }
}

class SearchModel extends ChangeNotifier {
  double _animationProgress = 0.0;

  double get animationProgress => _animationProgress;

  void setAnimationProgress(double progress) {
    _animationProgress = progress;
    notifyListeners();
  }

  Future<void> animateEntrance() async {
    const duration = Duration(milliseconds: 600);
    final startTime = DateTime.now();

    while (_animationProgress < 1.0) {
      final elapsedTime = DateTime.now().difference(startTime);
      _animationProgress = (elapsedTime.inMilliseconds / duration.inMilliseconds).clamp(0.0, 1.0);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 16)); // ~60 FPS
    }
  }
}
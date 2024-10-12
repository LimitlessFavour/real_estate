import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:real_estate/widget/properties_sheet.dart';

enum HomeTab { search, chat, home, favourites, profile }

class HomeModel extends ChangeNotifier {
  HomeTab _currentTab = HomeTab.home;
  double _animationProgress = 0.0;

  HomeTab get currentTab => _currentTab;
  double get animationProgress => _animationProgress;

  final GlobalKey<PropertiesSheetState> propertiesSheetKey = GlobalKey();

  void setHomeTab(HomeTab tab) {
    if (_currentTab != tab) {
      _currentTab = tab;
      propertiesSheetKey.currentState?.resetPosition();
      notifyListeners();
    }
  }

  void setAnimationProgress(double progress) {
    _animationProgress = progress;
    notifyListeners();
  }

  Future<void> animateEntrance() async {
    const duration = Duration(seconds: 10);
    final startTime = DateTime.now();

    while (_animationProgress < 1.0) {
      final elapsedTime = DateTime.now().difference(startTime);
      _animationProgress =
          (elapsedTime.inMilliseconds / duration.inMilliseconds)
              .clamp(0.0, 1.0);
      notifyListeners();
      await Future.delayed(const Duration(milliseconds: 16)); // ~60 FPS
    }
  }
}

import 'package:flutter/foundation.dart';

enum HomeTab { search, chat, home, favourites, profile }

class HomeModel extends ChangeNotifier {
  HomeTab _currentTab = HomeTab.home;

  HomeTab get currentTab => _currentTab;

  void setHomeTab(HomeTab tab) {
    if (_currentTab != tab) {
      _currentTab = tab;
      notifyListeners();
    }
  }
}

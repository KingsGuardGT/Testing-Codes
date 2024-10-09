import 'package:flutter/cupertino.dart';

class NavigationProvider extends ChangeNotifier {
  bool _isCollapsed = true; // Initially collapsed

  bool get isCollapsed => _isCollapsed;

  void toggleIsCollapsed() {
    _isCollapsed = !_isCollapsed;
    notifyListeners();
  }
}
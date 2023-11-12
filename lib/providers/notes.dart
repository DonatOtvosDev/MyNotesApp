import 'package:flutter/material.dart';

class Notes extends ChangeNotifier {
  String? _filter;

  String? get filter {
    return _filter;
  }

  void updateFilter(String newFilter) {
    _filter = newFilter;
    notifyListeners();
  }
}
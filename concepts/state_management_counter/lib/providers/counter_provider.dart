// ChangeNotifier is a mixin from the Flutter framework that provides an observable state.
// notifyListeners informs any listeners (widgets) to rebuild with the updated data.

import 'package:flutter/material.dart';

class CounterProvider with ChangeNotifier {
  int _counter = 0;

  int get counter => _counter;

  void incrementCounter() {
    _counter++;
    notifyListeners();
  }
}

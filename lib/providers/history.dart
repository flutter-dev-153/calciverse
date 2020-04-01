import 'package:flutter/foundation.dart';

class History with ChangeNotifier {
  final List<String> _historyItems = [];

  List<String> get historyItems {
    return [..._historyItems];
  }

  void addToHistory(String value) {
    _historyItems.add(value);
    notifyListeners();
  }
}
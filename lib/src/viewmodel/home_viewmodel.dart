import 'package:flutter/cupertino.dart';

class HomeViewModel with ChangeNotifier {
  int _indexSlider = 0;

  int get indexSlider => _indexSlider;

  /// index carousel slider
  void changeIndex({
    required int index,
  }) {
    _indexSlider = index;
    notifyListeners();
  }
}

import 'package:flutter/cupertino.dart';

class OnBoardingViewModel with ChangeNotifier {

  bool _lastPage = false;

  bool get lastpage => _lastPage;

  set lastPage(index) {
    _lastPage = index;
    notifyListeners();
  }

  void getStarted(index) {
    _lastPage = index;
    notifyListeners();
  }
}

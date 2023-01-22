import 'package:flutter/cupertino.dart';
import 'package:kkn_siwalan/src/dummy/onboarding_list.dart';
import 'package:kkn_siwalan/src/dummy/onboarding_model.dart';

class OnBoardingViewModel with ChangeNotifier {
  final List<OnBoardingModel> _onboarding = onBoardingList;

  List get onboarding => _onboarding;

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

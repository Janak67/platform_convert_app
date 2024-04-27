import 'package:flutter/material.dart';

class HomeProvider with ChangeNotifier {
  int stepIndex = 0;
  bool changeUI = true;

  void changeStep(i) {
    stepIndex = i;
    notifyListeners();
  }

  void changeAppUi(value) {
    changeUI = value;
    notifyListeners();
  }
}

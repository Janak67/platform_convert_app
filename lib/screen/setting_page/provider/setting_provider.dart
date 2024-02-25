import 'package:flutter/material.dart';
import '../../../utils/share_helper.dart';

class SettingProvider with ChangeNotifier {
  bool isShow = false;
  String? path;
  String? profileName;
  String? profileBio;

  void profileSwitch(value) {
    isShow = value;
    value = isShow;
    notifyListeners();
  }

  void updateImagePath(String? newpath) {
    path = newpath;
    notifyListeners();
  }

  // Theme
  bool isLight = true;

  void changeTheme() async {
    ShareHelper shr = ShareHelper();
    bool? isTheme = await shr.getTheme();
    isLight = isTheme ?? false;
    notifyListeners();
  }
}

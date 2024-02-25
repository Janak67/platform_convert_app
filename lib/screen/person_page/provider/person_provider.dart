import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';

class PersonProvider with ChangeNotifier {
  DateTime? date = DateTime.now();
  TimeOfDay? time = TimeOfDay.now();
  String? path;
  List<PersonModel> addPersonList = [];
  int dashIndex = 0;
  int? infoIndex = 0;

  void changeDate(DateTime? d1) {
    date = d1;
    notifyListeners();
  }

  void changeTime(TimeOfDay? d2) {
    time = d2;
    notifyListeners();
  }

  void updateImagePath(String? newpath) {
    path = newpath;
    notifyListeners();
  }

  void addContact(PersonModel pm) {
    addPersonList.add(pm);
    notifyListeners();
  }

  void changeStep(i) {
    dashIndex = i;
    notifyListeners();
  }

  void storeIndex(int index) {
    infoIndex = index;
    notifyListeners();
  }

  void editData(PersonModel p1) {
    addPersonList[infoIndex!] = p1;
    notifyListeners();
  }

  void contactDelete() {
    addPersonList.removeAt(infoIndex!);
    notifyListeners();
  }
}

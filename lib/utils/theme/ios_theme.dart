import 'package:flutter/cupertino.dart';

CupertinoThemeData lightCupertinoTheme = const CupertinoThemeData(
  brightness: Brightness.light,
  primaryColor: CupertinoColors.systemBlue,
  barBackgroundColor: CupertinoColors.white,
  scaffoldBackgroundColor: CupertinoColors.white,
  textTheme: CupertinoTextThemeData(
    navLargeTitleTextStyle:
        TextStyle(fontSize: 25, color: CupertinoColors.black),
    navTitleTextStyle: TextStyle(fontSize: 15, color: CupertinoColors.black),
  ),
);

CupertinoThemeData darkCupertinoTheme = const CupertinoThemeData(
  brightness: Brightness.dark,
  primaryColor: CupertinoColors.systemBlue,
  barBackgroundColor: CupertinoColors.black,
  scaffoldBackgroundColor: CupertinoColors.black,
  textTheme: CupertinoTextThemeData(
    navLargeTitleTextStyle:
        TextStyle(fontSize: 25, color: CupertinoColors.white),
    navTitleTextStyle: TextStyle(fontSize: 15, color: CupertinoColors.white),
  ),
);

import 'package:flutter/cupertino.dart';
import 'package:platform_convert_app/screen/home/view/home_screen.dart';
import 'package:platform_convert_app/screen/home/view/home_screen_ios.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const HomeScreen(),
};
Map<String, WidgetBuilder> screen_routes_ios = {
  '/': (context) => const HomeScreeniOS(),
};

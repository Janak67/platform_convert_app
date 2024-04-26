import 'package:flutter/cupertino.dart';
import 'package:platform_convert_app/screen/home/view/home_screen.dart';
import 'package:platform_convert_app/screen/home/view/home_screen_ios.dart';
import 'package:platform_convert_app/screen/splash/view/splash_screen.dart';
import 'package:platform_convert_app/screen/splash/view/splash_screen_ios.dart';

Map<String, WidgetBuilder> screen_routes = {
  '/': (context) => const SplashScreen(),
  'home': (context) => const HomeScreen(),
};
Map<String, WidgetBuilder> screen_routes_ios = {
  '/': (context) => const SplashScreeniOS(),
  'home': (context) => const HomeScreeniOS(),
};

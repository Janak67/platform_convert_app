import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/home/provider/home_provider.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:platform_convert_app/screen/setting_page/provider/setting_provider.dart';
import 'package:platform_convert_app/utils/app_routes.dart';
import 'package:platform_convert_app/utils/theme/android_theme.dart';
import 'package:platform_convert_app/utils/theme/ios_theme.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => HomeProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => PersonProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => SettingProvider(),
        ),
      ],
      child: Consumer<SettingProvider>(
        builder: (context, value, child) {
          value.changeTheme();
          return context.read<HomeProvider>().changeUI
              ? MaterialApp(
                  debugShowCheckedModeBanner: false,
                  routes: screen_routes,
                  theme: value.isLight ? lightTheme : darkTheme)
              : CupertinoApp(
                  debugShowCheckedModeBanner: false,
                  routes: screen_routes_ios,
                  theme:
                      value.isLight ? lightCupertinoTheme : darkCupertinoTheme);
        },
      ),
    ),
  );
}

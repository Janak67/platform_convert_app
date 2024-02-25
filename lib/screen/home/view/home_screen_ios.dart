import 'package:flutter/cupertino.dart';
import 'package:platform_convert_app/screen/call_page/view/call_screen_ios.dart';
import 'package:platform_convert_app/screen/chat_page/view/chat_screen_ios.dart';
import 'package:platform_convert_app/screen/person_page/view/person_screen_ios.dart';
import 'package:platform_convert_app/screen/setting_page/view/setting_screen_ios.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreeniOS extends StatefulWidget {
  const HomeScreeniOS({super.key});

  @override
  State<HomeScreeniOS> createState() => _HomeScreeniOSState();
}

class _HomeScreeniOSState extends State<HomeScreeniOS> {
  HomeProvider? providerr;
  HomeProvider? providerw;
  List<Widget> screen_ios = [
    const PersonScreenIOS(),
    const ChatScreenIOS(),
    const CallScreenIOS(),
    const SettingScreenIOS(),
  ];

  @override
  Widget build(BuildContext context) {
    providerr = context.read<HomeProvider>();
    providerw = context.watch<HomeProvider>();
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text(
          'Platform Converter',
          style: CupertinoTheme.of(context).textTheme.textStyle,
        ),
        trailing: CupertinoSwitch(
          value: providerr!.changeUI,
          onChanged: (value) {
            providerr!.changeAppUi(value);
          },
        ),
      ),
      child: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          activeColor: CupertinoColors.activeBlue,
          onTap: (value) {
            int i =value;
            providerr!.changeStep(i);
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.person_badge_plus,), label: 'Person'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.chat_bubble_2), label: 'Chat'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.phone), label: 'Phone'),
            BottomNavigationBarItem(
                icon: Icon(CupertinoIcons.settings), label: 'Setting'),
          ],
        ),
        tabBuilder: (context, index) {
          return CupertinoTabView(
            builder: (context) {
              return screen_ios[providerw!.stepIndex];
            },
          );
        },
      ),
    );
  }
}

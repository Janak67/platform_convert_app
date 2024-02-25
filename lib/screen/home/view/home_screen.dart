import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/call_page/view/call_screen.dart';
import 'package:platform_convert_app/screen/chat_page/view/chat_screen.dart';
import 'package:platform_convert_app/screen/person_page/view/person_screen.dart';
import 'package:platform_convert_app/screen/setting_page/view/setting_screen.dart';
import 'package:provider/provider.dart';

import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerr;
  HomeProvider? providerw;

  @override
  Widget build(BuildContext context) {
    providerr = context.read<HomeProvider>();
    providerw = context.watch<HomeProvider>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: DefaultTabController(
        length: 4,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            bottom: const TabBar(
              indicatorColor: Colors.deepPurple,
              labelColor: Colors.deepPurple,
              tabs: [
                Tab(
                  icon: Icon(
                    Icons.person_add_alt,
                    size: 25,
                  ),
                ),
                Tab(
                  child: Text(
                    'Chat',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    'Call',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
                Tab(
                  child: Text(
                    'Setting',
                    style: TextStyle(fontSize: 15),
                  ),
                ),
              ],
            ),
            title: const Text('Platform Converter'),
            actions: [
              Consumer(
                builder: (context, value, child) {
                  return Switch(
                    value: context.read<HomeProvider>().changeUI,
                    onChanged: (value) {
                      context.read<HomeProvider>().changeAppUi(value);
                    },
                  );
                },
              ),
              const SizedBox(width: 10),
            ],
          ),
          body: const TabBarView(
            children: [
              PersonScreen(),
              ChatScreen(),
              CallScreen(),
              SettingScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

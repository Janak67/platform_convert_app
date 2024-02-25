import 'package:flutter/cupertino.dart';

class SettingScreenIOS extends StatefulWidget {
  const SettingScreenIOS({super.key});

  @override
  State<SettingScreenIOS> createState() => _SettingScreenIOSState();
}

class _SettingScreenIOSState extends State<SettingScreenIOS> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 150),
          Text('Setting',style: TextStyle(fontSize: 45),),
          Icon(CupertinoIcons.calendar),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';

class CallScreenIOS extends StatefulWidget {
  const CallScreenIOS({super.key});

  @override
  State<CallScreenIOS> createState() => _CallScreenIOSState();
}

class _CallScreenIOSState extends State<CallScreenIOS> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 150),
          Text('Call',style: TextStyle(fontSize: 45),),
          Icon(CupertinoIcons.calendar),
        ],
      ),
    );
  }
}

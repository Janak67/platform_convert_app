import 'package:flutter/cupertino.dart';

class ChatScreenIOS extends StatefulWidget {
  const ChatScreenIOS({super.key});

  @override
  State<ChatScreenIOS> createState() => _ChatScreenIOSState();
}

class _ChatScreenIOSState extends State<ChatScreenIOS> {
  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(10),
      child: Column(
        children: [
          SizedBox(height: 150),
          Text('Chat',style: TextStyle(fontSize: 45),),
          Icon(CupertinoIcons.calendar),
        ],
      ),
    );
  }
}

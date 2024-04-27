import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:platform_convert_app/widget/update_ios_dialog.dart';
import 'package:provider/provider.dart';

class ChatScreenIOS extends StatefulWidget {
  const ChatScreenIOS({super.key});

  @override
  State<ChatScreenIOS> createState() => _ChatScreenIOSState();
}

class _ChatScreenIOSState extends State<ChatScreenIOS> {
  PersonProvider? providerr;
  PersonProvider? providerw;

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<PersonProvider>();
    providerr = context.read<PersonProvider>();
    return ListView.builder(
      itemCount: providerw!.addPersonList.length ?? 0,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            PersonModel p1 = PersonModel(
              name: providerr!.addPersonList[index].name,
              phone: providerr!.addPersonList[index].phone,
              imagePath: providerr!.addPersonList[index].imagePath,
            );
            providerr!.storeIndex(index);
            showiOSDialog(context, p1);
          },
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                providerw!.addPersonList[index].imagePath != null
                    ? CircleAvatar(
                        radius: 25,
                        backgroundImage: FileImage(File(
                            '${providerw!.addPersonList[index].imagePath}')),
                      )
                    : CircleAvatar(
                        radius: 25,
                        child: Text(
                          '${providerw!.addPersonList[index].name!.isNotEmpty ? providerw!.addPersonList[index].name!.substring(0, 1).toUpperCase() : 0}',
                          style: const TextStyle(
                              color: CupertinoColors.black, fontSize: 20),
                        ),
                      ),
                const SizedBox(width: 20),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${providerr!.addPersonList[index].name}',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${providerw!.addPersonList[index].chat}',
                      style: const TextStyle(fontSize: 15),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${providerr!.date!.day}/${providerr!.date!.month}/${providerr!.date!.year}',
                      style: const TextStyle(fontSize: 15),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${providerw!.time!.hour} : ${providerw!.time!.minute}',
                      style: const TextStyle(fontSize: 15),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

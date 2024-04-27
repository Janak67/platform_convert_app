import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:platform_convert_app/widget/android_dialog.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  PersonProvider? providerr;
  PersonProvider? providerw;

  @override
  Widget build(BuildContext context) {
    providerw = context.watch<PersonProvider>();
    providerr = context.read<PersonProvider>();
    return ListView.builder(
      itemCount: providerw!.addPersonList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.all(10),
          height: MediaQuery.sizeOf(context).height * 0.1,
          width: MediaQuery.sizeOf(context).width * 0.1,
          decoration: BoxDecoration(
            color: ([...Colors.primaries]..shuffle()).first.shade50,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Row(
              children: [
                providerw!.addPersonList[index].imagePath != null
                    ? InkWell(
                        onTap: () {
                          PersonModel p1 = PersonModel(
                            imagePath:
                                providerr!.addPersonList[index].imagePath,
                            name: providerr!.addPersonList[index].name,
                            phone: providerr!.addPersonList[index].phone,
                          );
                          providerr!.storeIndex(index);
                          showWidget(context, p1);
                        },
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: FileImage(
                            File(
                                "${providerw!.addPersonList[index].imagePath}"),
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          PersonModel p1 = PersonModel(
                            imagePath:
                                providerr!.addPersonList[index].imagePath,
                            name: providerr!.addPersonList[index].name,
                            phone: providerr!.addPersonList[index].phone,
                          );
                          providerr!.storeIndex(index);
                          showWidget(context, p1);
                        },
                        child: Container(
                          height: MediaQuery.sizeOf(context).height * 0.18,
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          decoration:
                              const BoxDecoration(shape: BoxShape.circle),
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              "${providerw!.addPersonList[index].name!.isNotEmpty ? providerw!.addPersonList[index].name!.substring(0, 1).toUpperCase() : 0}",
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                            ),
                          ),
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
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(
                      '${providerw!.addPersonList[index].chat}',
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '${providerr!.date!.day}/${providerr!.date!.month}/${providerr!.date!.year}',
                      style: const TextStyle(color: Colors.black),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      '${providerw!.time!.hour} : ${providerw!.time!.minute}',
                      style: const TextStyle(color: Colors.black),
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

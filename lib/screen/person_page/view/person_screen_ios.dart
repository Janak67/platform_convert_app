import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:provider/provider.dart';
import '../provider/person_provider.dart';

class PersonScreenIOS extends StatefulWidget {
  const PersonScreenIOS({super.key});

  @override
  State<PersonScreenIOS> createState() => _PersonScreenIOSState();
}

class _PersonScreenIOSState extends State<PersonScreenIOS> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  PersonProvider? providerr;
  PersonProvider? providerw;
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtChat = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();

  @override
  Widget build(BuildContext context) {
    providerr = context.read<PersonProvider>();
    providerw = context.watch<PersonProvider>();
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 110),
              Consumer<PersonProvider>(
                builder: (context, value, child) => GestureDetector(
                  onTap: () {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: const Text('Choose Photo'),
                          actions: [
                            GestureDetector(
                              onTap: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? img = await picker.pickImage(
                                    source: ImageSource.camera);
                                providerr!.updateImagePath(img!.path);
                                Navigator.pop(context);
                              },
                              child:
                                  const Icon(CupertinoIcons.camera, size: 75),
                            ),
                            GestureDetector(
                              onTap: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? img = await picker.pickImage(
                                    source: ImageSource.gallery);
                                providerr!.updateImagePath(img!.path);
                                Navigator.pop(context);
                              },
                              child: const Icon(CupertinoIcons.photo, size: 75),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: CircleAvatar(
                    radius: h * 0.075,
                    foregroundImage: value.path != null
                        ? FileImage(File(value.path!))
                        : null,
                    child: Icon(CupertinoIcons.photo_camera, size: w * 0.1),
                  ),
                ),
              ),
              SizedBox(height: h * 0.03),
              CupertinoTextFormFieldRow(
                prefix: const Icon(CupertinoIcons.person),
                placeholder: "Full Name",
                controller: txtName,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: CupertinoColors.systemGrey, width: 1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Full Name";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.01),
              CupertinoTextFormFieldRow(
                prefix: const Icon(CupertinoIcons.phone),
                placeholder: "Phone Number",
                controller: txtPhone,
                keyboardType: TextInputType.number,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: CupertinoColors.systemGrey, width: 1),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter Your Phone Number";
                  }
                  return null;
                },
              ),
              SizedBox(height: h * 0.01),
              CupertinoTextFormFieldRow(
                prefix: const Icon(CupertinoIcons.chat_bubble_text),
                placeholder: "Chat Conversation",
                controller: txtChat,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border:
                      Border.all(color: CupertinoColors.systemGrey, width: 1),
                ),
              ),
              SizedBox(height: h * 0.015),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) => SizedBox(
                            height: 200,
                            child: CupertinoDatePicker(
                              use24hFormat: false,
                              initialDateTime: providerr!.date,
                              onDateTimeChanged: (value) {
                                providerr!.changeDate(value);
                              },
                              backgroundColor: CupertinoColors.white,
                            ),
                          ),
                        );
                      },
                      child: const Icon(CupertinoIcons.calendar_today),
                    ),
                    const SizedBox(width: 10),
                    Text(
                        'Date:- ${providerr!.date?.day} / ${providerr!.date?.month} / ${providerr!.date?.year}'),
                  ],
                ),
              ),
              SizedBox(height: h * 0.01),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return SizedBox(
                              height: 200,
                              child: CupertinoTimerPicker(
                                mode: CupertinoTimerPickerMode.hm,
                                backgroundColor: CupertinoColors.white,
                                onTimerDurationChanged: (value) {
                                  List<String> l1 = value.toString().split(':');
                                  TimeOfDay? t1 = TimeOfDay(
                                    hour: int.parse(l1[0]),
                                    minute: int.parse(l1[1]),
                                  );
                                  providerr!.changeTime(t1);
                                },
                                initialTimerDuration: Duration(
                                  hours: providerr!.time!.hour,
                                  minutes: providerr!.time!.minute,
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: const Icon(CupertinoIcons.time),
                    ),
                    const SizedBox(width: 10),
                    Text(
                        'Time:- ${providerr!.time!.hour} : ${providerr!.time!.minute}')
                  ],
                ),
              ),
              CupertinoButton.filled(
                borderRadius: BorderRadius.circular(30),
                child: const Text('Save'),
                onPressed: () {
                  if (formKey.currentState?.validate() ?? false) {
                    PersonModel pm = PersonModel(
                      name: txtName.text,
                      phone: txtPhone.text,
                      chat: txtChat.text,
                      time: txtTime.text,
                      date: txtDate.text,
                      imagePath: providerw!.path,
                    );
                    providerr!.updateImagePath(null);
                    providerr!.addContact(pm);
                    providerw!.dashIndex;
                    txtName.clear();
                    txtPhone.clear();
                    txtPhone.clear();
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

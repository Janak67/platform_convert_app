import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:platform_convert_app/widget/show_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PersonScreen extends StatefulWidget {
  const PersonScreen({super.key});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtChat = TextEditingController();
  TextEditingController txtDate = TextEditingController();
  TextEditingController txtTime = TextEditingController();
  PersonProvider? providerr;
  PersonProvider? providerw;

  @override
  Widget build(BuildContext context) {
    providerr = context.read<PersonProvider>();
    providerw = context.watch<PersonProvider>();
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(w * 0.04),
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: h * 0.01),
              Consumer<PersonProvider>(
                builder: (context, value, child) => InkWell(
                  onTap: () {
                    showBottom(context);
                  },
                  child: CircleAvatar(
                    radius: h * 0.075,
                    foregroundImage: value.path != null
                        ? FileImage(File(value.path!))
                        : null,
                    child: Icon(Icons.add_a_photo_outlined, size: w * 0.1),
                  ),
                ),
              ),
              SizedBox(height: h * 0.04),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: 'Full Name'),
                      controller: txtName,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required your Name';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: h * 0.02),
                    TextFormField(
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.phone),
                          hintText: 'Phone Number'),
                      controller: txtPhone,
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Required your Phone Number';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: h * 0.02),
                    TextFormField(
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.message_outlined),
                            hintText: 'Chat Conversation'),
                        controller: txtChat),
                  ],
                ),
              ),
              SizedBox(height: h * 0.015),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      DateTime? d1 = await showDatePicker(
                          context: context,
                          initialDate: providerr!.date!,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                          initialDatePickerMode: DatePickerMode.day);
                      providerr!.changeDate(d1!);
                    },
                    icon: Icon(Icons.calendar_month_rounded, size: h * 0.03),
                  ),
                  Text(
                    'Date:- ${providerr!.date?.day} / ${providerr!.date?.month} / ${providerr!.date?.year}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: w * 0.04),
                  ),
                ],
              ),
              SizedBox(height: h * 0.01),
              Row(
                children: [
                  IconButton(
                    onPressed: () async {
                      TimeOfDay? d2 = await showTimePicker(
                          context: context, initialTime: providerr!.time!);
                      providerr!.changeTime(d2!);
                    },
                    icon: Icon(Icons.watch_later_outlined, size: h * 0.03),
                  ),
                  Text(
                    'Time:- ${providerr!.time!.hour} : ${providerr!.time!.minute}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, fontSize: w * 0.04),
                  ),
                ],
              ),
              OutlinedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    PersonModel pm = PersonModel(
                        imagePath: providerw!.path,
                        name: txtName.text,
                        chat: txtChat.text,
                        phone: txtPhone.text,
                        date: txtDate.text,
                        time: txtTime.text);
                    providerr!.updateImagePath(null);
                    providerr!.addContact(pm);
                    providerw!.dashIndex;
                    txtName.clear();
                    txtChat.clear();
                    txtPhone.clear();
                  }
                },
                child: const Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

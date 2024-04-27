import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:platform_convert_app/screen/setting_page/provider/setting_provider.dart';
import 'package:platform_convert_app/utils/share_helper.dart';
import 'package:platform_convert_app/widget/show_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingScreenIOS extends StatefulWidget {
  const SettingScreenIOS({super.key});

  @override
  State<SettingScreenIOS> createState() => _SettingScreenIOSState();
}

class _SettingScreenIOSState extends State<SettingScreenIOS> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController txtProfileName = TextEditingController();
  TextEditingController txtProfileBio = TextEditingController();
  SettingProvider? providerr;
  SettingProvider? providerw;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double h = size.height;
    double w = size.width;
    providerr = context.read<SettingProvider>();
    providerw = context.watch<SettingProvider>();
    return CupertinoPageScaffold(
      child: SingleChildScrollView(
        child: Column(
          children: [
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.person, size: 30),
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Update Profile Data'),
              trailing: CupertinoSwitch(
                value: providerr!.isShow,
                onChanged: (value) {
                  providerr!.profileSwitch(value);
                },
              ),
            ),
            SizedBox(height: h * 0.01),
            (providerr!.isShow == true)
                ? Column(
                    children: [
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
                                      child: const Icon(CupertinoIcons.camera,
                                          size: 75),
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        ImagePicker picker = ImagePicker();
                                        XFile? img = await picker.pickImage(
                                            source: ImageSource.gallery);
                                        providerr!.updateImagePath(img!.path);
                                        Navigator.pop(context);
                                      },
                                      child: const Icon(CupertinoIcons.photo,
                                          size: 75),
                                    ),
                                  ],
                                );
                              },
                            );
                          },
                          child: CircleAvatar(
                            radius: h * 0.07,
                            foregroundImage: value.path != null
                                ? FileImage(File(value.path!))
                                : null,
                            child: Icon(CupertinoIcons.photo_camera,
                                size: w * 0.1),
                          ),
                        ),
                      ),
                      SizedBox(height: h * 0.025),
                      Column(
                        children: [
                          CupertinoTextFormFieldRow(
                            textAlign: TextAlign.center,
                            placeholder: 'Enter your Name',
                            controller: txtProfileName,
                            onSaved: (newValue) {
                              providerr!.profileName = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Name';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: h * 0.02),
                          CupertinoTextFormFieldRow(
                            textAlign: TextAlign.center,
                            placeholder: 'Enter your Bio',
                            controller: txtProfileBio,
                            onSaved: (newValue) {
                              providerr!.profileBio = newValue;
                            },
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Enter your Bio';
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: h * 0.025),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              CupertinoButton(
                                onPressed: () {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    formKey.currentState!.save();
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(
                                      color: CupertinoColors.systemPurple),
                                ),
                              ),
                              CupertinoButton(
                                onPressed: () {
                                  txtProfileName.clear();
                                  txtProfileBio.clear();
                                },
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(
                                      color: CupertinoColors.systemPurple),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            SizedBox(height: h * 0.01),
            CupertinoListTile(
              leading: const Icon(CupertinoIcons.light_max, size: 30),
              title: const Text(
                'Theme',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Change Theme'),
              trailing: Consumer<SettingProvider>(
                builder: (context, value, child) => CupertinoSwitch(
                  value: value.isLight,
                  onChanged: (value1) {
                    ShareHelper shr = ShareHelper();
                    shr.setTheme(value1);
                    value.changeTheme();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

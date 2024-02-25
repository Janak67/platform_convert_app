import 'dart:io';
import 'package:flutter/material.dart';
import 'package:platform_convert_app/screen/setting_page/provider/setting_provider.dart';
import 'package:platform_convert_app/utils/share_helper.dart';
import 'package:platform_convert_app/widget/bottom_sheet_setting.dart';
import 'package:provider/provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  GlobalKey<FormState> formKey1 = GlobalKey<FormState>();
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            ListTile(
              leading: const Icon(Icons.person, size: 30),
              title: const Text(
                'Profile',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Update Profile Data'),
              trailing: Switch(
                value: providerr!.isShow,
                onChanged: (value) {
                  providerr!.profileSwitch(value);
                },
              ),
            ),
            SizedBox(height: h * 0.01),
            (providerr!.profileSwitch == true)
                ? Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          showBottomWidget(context);
                        },
                        child: CircleAvatar(
                          radius: h * 0.085,
                          foregroundImage: providerr!.path != null
                              ? FileImage(File(providerr!.path!))
                              : null,
                          child:
                              Icon(Icons.add_a_photo_outlined, size: w * 0.1),
                        ),
                      ),
                      SizedBox(height: h * 0.025),
                      Column(
                        children: [
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                enabled: true,
                                enabledBorder: InputBorder.none,
                                hintText: 'Enter your Name'),
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
                          TextFormField(
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              enabledBorder: InputBorder.none,
                              hintText: 'Enter your Bio',
                            ),
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
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey1.currentState!.validate()) {
                                    formKey1.currentState!.save();
                                  }
                                },
                                child: const Text(
                                  'Save',
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  txtProfileName.clear();
                                  txtProfileBio.clear();
                                },
                                child: const Text(
                                  'Clear',
                                  style: TextStyle(color: Colors.deepPurple),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  )
                : Container(),
            const Divider(),
            SizedBox(height: h * 0.01),
            ListTile(
              leading: const Icon(
                Icons.light_mode_outlined,
                size: 30,
              ),
              title: const Text(
                'Theme',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Change Theme'),
              trailing: Consumer<SettingProvider>(
                builder: (context, value, child) => Switch(
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

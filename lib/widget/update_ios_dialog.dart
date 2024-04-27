import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:provider/provider.dart';

void showiOSDialog(BuildContext context, PersonModel p1) {
  TextEditingController txtName = TextEditingController(text: p1.name);
  TextEditingController txtChat = TextEditingController(text: p1.chat);
  TextEditingController txtPhone = TextEditingController(text: p1.phone);
  showCupertinoDialog(
    context: context,
    builder: (context) {
      return CupertinoAlertDialog(
        title: const Text('Update Contact'),
        content: SingleChildScrollView(
          child: Column(
            children: [
              CupertinoDialogAction(
                child: p1.imagePath != null ||
                        context.read<PersonProvider>().path != null
                    ? CircleAvatar(
                        radius: 70,
                        backgroundImage: FileImage(File('${p1.imagePath}')),
                      )
                    : CircleAvatar(
                        radius: 80,
                        child: Text(p1.name!.substring(0, 1).toUpperCase(),
                            style: CupertinoTheme.of(context)
                                .textTheme
                                .navLargeTitleTextStyle),
                      ),
                onPressed: () {
                  showCupertinoDialog(
                    context: context,
                    builder: (context) {
                      return CupertinoAlertDialog(
                        title: const Text('Pick Profile Picture'),
                        actions: [
                          CupertinoDialogAction(
                            child: const Text('Choose Photo'),
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.gallery);
                              context
                                  .read<PersonProvider>()
                                  .updateImagePath(image!.path);
                              Navigator.pop(context);
                            },
                          ),
                          CupertinoDialogAction(
                            child: const Text('Take Photo'),
                            onPressed: () async {
                              ImagePicker picker = ImagePicker();
                              XFile? image = await picker.pickImage(
                                  source: ImageSource.camera);
                              context
                                  .read<PersonProvider>()
                                  .updateImagePath(image!.path);
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
              const SizedBox(height: 10),
              CupertinoTextField(
                  controller: txtName,
                  placeholder: 'Name',
                  keyboardType: TextInputType.name),
              const SizedBox(height: 10),
              CupertinoTextField(
                  controller: txtPhone,
                  placeholder: 'Phone',
                  keyboardType: TextInputType.number),
              const SizedBox(height: 10),
              CupertinoTextField(
                  controller: txtChat,
                  placeholder: 'Chat',
                  keyboardType: TextInputType.text),
            ],
          ),
        ),
        actions: [
          CupertinoDialogAction(
            onPressed: () {
              PersonModel p1 = PersonModel();
              p1.name = txtName.text;
              p1.phone = txtPhone.text;
              p1.chat = txtChat.text;
              p1.imagePath = context.read<PersonProvider>().path;
              context.read<PersonProvider>().editData(p1);
              Navigator.pop(context);
            },
            child: const Text('Update'),
          ),
          CupertinoButton(
            onPressed: () {
              context.read<PersonProvider>().contactDelete();
              Navigator.pop(context);
            },
            child: const Text('Delete'),
          )
        ],
      );
    },
  );
}

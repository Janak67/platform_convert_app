import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/screen/person_page/model/person_model.dart';
import 'package:platform_convert_app/screen/person_page/provider/person_provider.dart';
import 'package:provider/provider.dart';

void showWidget(BuildContext context, PersonModel p1) {
  TextEditingController txtName = TextEditingController(text: p1.name);
  TextEditingController txtChat = TextEditingController(text: p1.chat);
  TextEditingController txtPhone = TextEditingController(text: p1.phone);
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  showDialog(
    context: context,
    builder: (context) {
      return Form(
        key: formKey,
        child: SingleChildScrollView(
          child: AlertDialog(
            title: const Text("Update Contact"),
            actions: [
              Align(
                alignment: Alignment.center,
                child: InkWell(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          alignment: Alignment.bottomCenter,
                          title: const Text("Pick Profile Picture"),
                          actions: [
                            TextButton(
                                onPressed: () async {
                                  ImagePicker picker = ImagePicker();
                                  XFile? image = await picker.pickImage(
                                      source: ImageSource.gallery);
                                  // ignore: use_build_context_synchronously
                                  context
                                      .read<PersonProvider>()
                                      .updateImagePath(image!.path);
                                  Navigator.pop(context);
                                },
                                child: const Text("Choose Photo")),
                            TextButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                XFile? image = await picker.pickImage(
                                    source: ImageSource.camera);
                                // ignore: use_build_context_synchronously
                                context
                                    .read<PersonProvider>()
                                    .updateImagePath(image!.path);
                                Navigator.pop(context);
                              },
                              child: const Text("Take Photo"),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  child: p1.imagePath != null ||
                          context.read<PersonProvider>().path != null
                      ? CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(File("${p1.imagePath}")),
                        )
                      : CircleAvatar(
                          radius: 80,
                          child: Text(p1.name!.substring(0, 1).toUpperCase(),
                              style: Theme.of(context).textTheme.titleLarge),
                        ),
                ),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtName,
                keyboardType: TextInputType.name,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Name")),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtPhone,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Phone")),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: txtChat,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), label: Text("Chat")),
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  OutlinedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        PersonModel c1 = PersonModel();
                        c1.name = txtName.text;
                        c1.chat = txtChat.text;
                        c1.phone = txtPhone.text;
                        c1.imagePath = context.read<PersonProvider>().path;
                        context.read<PersonProvider>().editData(c1);
                        Navigator.pop(context);
                      }
                    },
                    child: const Text("Update"),
                  ),
                  OutlinedButton(
                    onPressed: () {
                      context.read<PersonProvider>().contactDelete();
                    },
                    child: const Text("Delete"),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    },
  );
}

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:platform_convert_app/screen/setting_page/provider/setting_provider.dart';
import 'package:provider/provider.dart';

void showBottomWidget(BuildContext context) {
  SettingProvider? providerr;
  Size size = MediaQuery.of(context).size;
  double w = size.width;
  providerr = context.read<SettingProvider>();
  showModalBottomSheet(
    context: context,
    builder: (context) {
      return Container(
        height: 180,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text('Choose Photo',
                style: TextStyle(
                    fontSize: w * 0.05,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? img =
                            await picker.pickImage(source: ImageSource.camera);
                        providerr!.updateImagePath(img!.path);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.camera_alt_outlined,
                          size: w * 0.20, color: Colors.black),
                    ),
                    Text(
                      'Camera',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.04),
                    ),
                  ],
                ),
                Column(
                  children: [
                    IconButton(
                      onPressed: () async {
                        ImagePicker picker = ImagePicker();
                        XFile? img =
                            await picker.pickImage(source: ImageSource.gallery);
                        providerr!.updateImagePath(img!.path);
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.photo_camera_back_outlined,
                          size: w * 0.2, color: Colors.black),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: w * 0.04),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
    },
  );
}

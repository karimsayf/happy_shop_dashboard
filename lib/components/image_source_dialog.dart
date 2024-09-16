import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ImageSourceDialog extends StatelessWidget {
  final Function(PlatformFile pickedImg) callBack;

  const ImageSourceDialog({Key? key, required this.callBack}) : super(key: key);

  Future<void> _getImage(BuildContext context) async {
    FilePickerResult? pickedFile = await FilePicker.platform.pickFiles();

    if (pickedFile != null) {
      callBack(pickedFile.files.first);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      children: [
        /*ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('التقاط بواسطة الكاميرا'),
          onTap: () {
            Navigator.pop(
              context,
            );
            _getImage(context);
          },
        ),*/
        ListTile(
          leading: const Icon(Icons.image),
          title:  const Text("اختيار من المعرض"),
          onTap: () {
            Navigator.pop(
              context,
            );
            _getImage(context);
          },
        ),
      ]
    );
  }
}

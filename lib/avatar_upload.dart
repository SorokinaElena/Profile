import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_cropper/image_cropper.dart';


class AvatarUpload extends StatefulWidget {
  const AvatarUpload({super.key});

  @override
  State<AvatarUpload> createState() {
    return _AvatarUploadState();
  }
}

class _AvatarUploadState extends State<AvatarUpload> {
  File? _image;

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _image == null
          ? IconButton(
              iconSize: 40,
              onPressed: _pickImage,
              icon: const Icon(Icons.add_a_photo_outlined),
            )
          : GestureDetector(
              onTap: _pickImage,
              child: ClipOval(
                child: Image.file(_image!,
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
            ),
    );
  }
}

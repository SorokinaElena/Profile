import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
//import 'package:image_cropper/image_cropper.dart';

class AvatarUpload extends StatefulWidget {
  AvatarUpload({super.key, required this.image, required this.imagePath});

  File? image;
  String imagePath;

  @override
  State<AvatarUpload> createState() {
    return _AvatarUploadState();
  }
}

class _AvatarUploadState extends State<AvatarUpload> {
  
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final currentImage = File(pickedFile.path);
      final isValidateImage = await _validateImage(currentImage);
      if (isValidateImage) {
        setState(() {
          widget.image = currentImage;
        });

        widget.imagePath = widget.image!.path;
        /* print('first pass: $_imagePath');
        print('first: $_image'); */
      }
    }
  }

  Future<bool> _validateImage(File imageFile) async {
    const List<String> allowedFormats = ['jpg', 'jpeg', 'png'];
    const int maxSize = 5 * 1024 * 1024;

    if (await imageFile.length() > maxSize) {
      return false;
    }

    final String fileExtension = imageFile.path.split('.').last.toLowerCase();
    if (!allowedFormats.contains(fileExtension)) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: widget.image == null
          ? IconButton(
              iconSize: 40,
              onPressed: _pickImage,
              icon: const Icon(Icons.add_a_photo_outlined),
            )
          : GestureDetector(
              onTap: _pickImage,
              child: ClipOval(
                child: Image.file(widget.image!,
                    width: 120, height: 120, fit: BoxFit.cover),
              ),
            ),
    );
  }
}

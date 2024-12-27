import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ImageStorage {
  Future<File> uploadImage(String inputSource) async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? image = await imagePicker.pickImage(
        source: inputSource == 'gallery'
            ? ImageSource.gallery
            : ImageSource.camera);

    File imageFile = File(image!.path);
    return imageFile;
  }
}

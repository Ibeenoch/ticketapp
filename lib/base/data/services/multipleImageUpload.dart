import 'dart:io';

import 'package:parse_server_sdk/parse_server_sdk.dart';

Future<List<String>> multipleImageUploads(List<File> selectedImages) async {
  List<String> listOfImages = [];
  try {
    for (File img in selectedImages) {
      final parseFile = ParseFile(img);

      final response = await parseFile.save();
      if (response.success) {
        listOfImages.add(response.result.url);
      } else {
        print('error uploading the image to the server');
      }
    }

    return listOfImages;
  } catch (e) {
    return listOfImages;
    print('Error uploading images $e ');
  }
}

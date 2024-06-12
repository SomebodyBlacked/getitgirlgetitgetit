import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  static ImageController get to => Get.find<ImageController>();
  final storage = FirebaseStorage.instance;

  File? image;
  final _picker = ImagePicker();
  var imageURL = "".obs;

  Future<void> getImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      image = File(pickedFile.path);
      imageURL.value = image!.path;
      imageURL.refresh();
      Get.snackbar("Success", "Image selected.$imageURL");
      update();
    } else {
      Get.snackbar("Error", "No image selected.");
    }
  }

  Future<void> saveImage() async {
    if (kIsWeb) {
      Get.snackbar("Error", "Web not supported.");
      return;
    }
    EasyLoading.show(status: 'Saving...');
    if (image != null) {
      await storage
          .ref("images/${DateTime.now().toString()}.jpg")
          .putFile(image!);
      Get.snackbar("Success", "Image saved to Firebase.");
      imageURL.value = "";
      imageURL.refresh();
      image = null;
      update();
    } else {
      Get.snackbar("Error", "No image selected.");
    }
    EasyLoading.dismiss();
  }
}

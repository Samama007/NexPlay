import 'dart:io';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ImageController extends GetxController {
  Rx<File?> profileImage = Rx<File?>(null); // Rx to make it reactive

  Future<void> pickImage() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      profileImage.value = File(image.path); // Store the selected image in memory
    }
  }
}

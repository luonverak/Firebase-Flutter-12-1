import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageController extends GetxController {
  XFile? file;
  RxString imageURL = "".obs;
  Future openGallery() async {
    final fileChoose =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    file = XFile(fileChoose!.path);
    update();
  }

  Future openCamera() async {
    final fileChoose =
        await ImagePicker().pickImage(source: ImageSource.camera);
    file = XFile(fileChoose!.path);
    update();
  }

  Future uploadFile(XFile files) async {
    var time = DateTime.now().toString();
    final refsRoot = FirebaseStorage.instance.ref();
    final refsImage = refsRoot.child('Image');
    final refsUpload = refsImage.child('$time-${files.name}');
    try {
      await refsUpload.putFile(File(file!.path));
      imageURL.value = await refsUpload.getDownloadURL();
      print(imageURL);
    } catch (e) {
      print(e);
    }
    update();
  }
}

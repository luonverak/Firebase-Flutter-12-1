import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class StorageController extends GetxController {
  XFile? file;
  late String imageURL = "";

  Future openGallery() async {
    try {
      final fileChoose =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      file = XFile(fileChoose!.path);
    } catch (e) {
      print(e);
    }
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
      imageURL = await refsUpload.getDownloadURL();
      // print(imageURL);
    } catch (e) {
      print(e);
    }
    update();
  }
}

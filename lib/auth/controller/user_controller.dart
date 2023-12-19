import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_flutter/auth/model/user_model.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  Future<void> createUser(UserModel model) async {
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (credential.user != null) {
        Get.snackbar('Success', 'Account create success');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar('Error', 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        Get.snackbar('Error', 'The account already exists for that email.');
      } else {
        Get.snackbar('Error', 'Something wrong');
      }
    } catch (e) {
      print(e);
    }
    update();
  }

  Future<void> loginUser(UserModel model) async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: model.email,
        password: model.password,
      );
      if (credential.user != null) {
        Get.snackbar('Success', 'Account login success');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        Get.snackbar('Error', 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        Get.snackbar('Error', 'Wrong password provided for that user.');
      } else {
        Get.snackbar('Error', 'Something wrong.');
      }
    }
    update();
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('product');
  Future<void> addProduct(ProductModel model) {
    return users
        .add(model.fromJson())
        .then((value) => print("Added"))
        .catchError((error) => print("Failed : $error"));
  }
}

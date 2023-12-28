import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/home/model/product_model.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference product =
      FirebaseFirestore.instance.collection('product');
  Future<void> addProduct(ProductModel model) {
    return product
        .add(model.fromJson())
        .then((value) => print("Added"))
        .catchError((error) => print("Failed : $error"));
  }

  Future<void> deleteProduct(String docId) {
    return product
        .doc(docId)
        .delete()
        .then((value) => print(" Deleted"))
        .catchError((error) => print("Failed : $error"));
  }

  Future<void> editProduct(ProductModel model, {required String docId}) {
    return product
        .doc(docId)
        .set(model.fromJson())
        .then((value) => print("Updated"))
        .catchError((error) => print("Failed : $error"));
  }
}

import 'dart:io';
import 'dart:math';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:firebase_flutter/home/controller/product_controller.dart';
import 'package:firebase_flutter/home/controller/storage_controller.dart';
import 'package:firebase_flutter/home/model/product_model.dart';
import 'package:firebase_flutter/home/view/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import '../widget/input_field.dart';
import '../widget/loading.dart';

class AddEditScreen extends StatelessWidget {
  AddEditScreen({super.key, this.productModel, this.docId});
  late ProductModel? productModel;
  late String? docId;
  final storageController = Get.put(StorageController());
  final productController = Get.put(ProductController());
  final nameController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();
  RxBool check = false.obs;
  String imageURL = "";
  reloadUpdate() {
    nameController.text = productModel!.name;
    priceController.text = productModel!.price.toString();
    descriptionController.text = productModel!.description;
    imageURL = productModel!.image;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(productModel == null ? 'Add product' : 'Edit product'),
        actions: [
          IconButton(
            onPressed: () async {
              openLoading();
              await storageController.uploadFile(
                XFile(
                  storageController.file!.path,
                ),
              );
              (productModel == null)
                  ? await productController.addProduct(
                      ProductModel(
                        id: Random().nextInt(10000),
                        name: nameController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        image: storageController.imageURL,
                      ),
                    )
                  : await productController.editProduct(
                      ProductModel(
                        id: productModel!.id,
                        name: nameController.text,
                        description: descriptionController.text,
                        price: double.parse(priceController.text),
                        image: (storageController.imageURL == "")
                            ? productModel!.image
                            : storageController.imageURL,
                      ),
                      docId: docId!,
                    );
              closeLoading();
              Get.back();
              print(docId);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Obx(
        () => Visibility(
          visible: check.value,
          replacement: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    GetBuilder<StorageController>(
                      init: productModel == null
                          ? StorageController()
                          : reloadUpdate(),
                      builder: (controller) => (productModel == null)
                          ? Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                                image: (storageController.file == null)
                                    ? const DecorationImage(
                                        image: AssetImage(
                                            'asset/image/thumbnail.png'),
                                      )
                                    : DecorationImage(
                                        fit: BoxFit.cover,
                                        image: FileImage(
                                          File(storageController.file!.path),
                                        ),
                                      ),
                              ),
                            )
                          : Container(
                              width: 200,
                              height: 200,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.amber,
                                border: Border.all(
                                  width: 2,
                                  color: Colors.blue,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(imageURL),
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      bottom: 20,
                      right: 10,
                      child: GestureDetector(
                        onTap: () {
                          showAdaptiveActionSheet(
                            context: context,
                            actions: <BottomSheetAction>[
                              BottomSheetAction(
                                title: const Text('Choose Gallery'),
                                onPressed: (context) async =>
                                    await storageController
                                        .openGallery()
                                        .whenComplete(
                                          () => Get.back(),
                                        ),
                              ),
                              BottomSheetAction(
                                title: const Text('Open Camera'),
                                onPressed: (context) async =>
                                    await storageController
                                        .openCamera()
                                        .whenComplete(
                                          () => Get.back(),
                                        ),
                              ),
                            ],
                            cancelAction: CancelAction(
                              title: const Text('Cancel'),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            color: const Color.fromARGB(255, 208, 208, 208),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.all(5.0),
                            child: Icon(
                              Icons.camera_alt,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                InputField(
                  controller: nameController,
                  hintText: 'Product name',
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  controller: priceController,
                  hintText: 'Product price',
                ),
                const SizedBox(
                  height: 15,
                ),
                InputField(
                  controller: descriptionController,
                  hintText: 'Product descriptions',
                  maxLines: 7,
                ),
              ],
            ),
          ),
          child: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}

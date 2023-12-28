import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_flutter/auth/controller/user_controller.dart';
import 'package:firebase_flutter/home/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

import '../controller/product_controller.dart';
import 'add_edit_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(UserController());
  final productController = Get.put(ProductController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async => controller.logoutUser(),
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('product').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data!.docs[index];
                  return Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Slidable(
                      endActionPane: ActionPane(
                        motion: const ScrollMotion(),
                        children: [
                          SlidableAction(
                            borderRadius: BorderRadius.circular(10),
                            onPressed: (context) async {
                              await productController.deleteProduct(item.id);
                            },
                            backgroundColor: const Color(0xFFFE4A49),
                            foregroundColor: Colors.white,
                            icon: Icons.delete,
                            label: 'Delete',
                          ),
                          SlidableAction(
                            borderRadius: BorderRadius.circular(10),
                            onPressed: (context) async => Get.to(
                              AddEditScreen(
                                productModel: ProductModel(
                                  id: item.get('id'),
                                  name: item.get('name'),
                                  description: item.get('description'),
                                  price: item.get('price'),
                                  image: item.get('image'),
                                ),
                                docId: item.id,
                              ),
                            ),
                            backgroundColor: const Color(0xFF21B7CA),
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                          ),
                        ],
                      ),
                      child: SizedBox(
                        height: 100,
                        child: Card(
                          child: Row(
                            children: [
                              Container(
                                width: 100,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: NetworkImage(
                                      item.get('image'),
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item.get('name'),
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      item.get('description'),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      '\$ ${item.get('price')}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: Colors.red),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return const Center(
              child: Icon(Icons.error),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async => Get.to(AddEditScreen()),
        child: const Icon(Icons.add),
      ),
    );
  }
}

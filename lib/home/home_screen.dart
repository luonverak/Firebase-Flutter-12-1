import 'package:firebase_flutter/auth/controller/user_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('App'),
        actions: [
          IconButton(
            onPressed: () async => controller.logoutUser(),
            icon: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

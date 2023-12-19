import 'package:firebase_flutter/auth/controller/user_controller.dart';
import 'package:firebase_flutter/auth/model/user_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/buttons.dart';
import '../widget/input_field.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final cf_password = TextEditingController();
  final controller = Get.put(UserController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 248, 218, 228),
              Color.fromARGB(255, 212, 227, 252)
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.5, 0.05),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () async => Get.back(),
                    icon: const Icon(Icons.arrow_back),
                  ),
                  const Spacer(),
                  const Text(
                    'Create account',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(
                    flex: 2,
                  ),
                ],
              ),
              const SizedBox(
                height: 60,
              ),
              InputField(
                controller: email,
                hintText: 'Enter Email',
                prefixIcon: Icons.email,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                controller: password,
                hintText: 'Enter Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility_off,
              ),
              const SizedBox(
                height: 20,
              ),
              InputField(
                controller: cf_password,
                hintText: 'Confirm Password',
                prefixIcon: Icons.lock,
                suffixIcon: Icons.visibility_off,
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  if (password.text == cf_password.text) {
                    await controller.createUser(
                      UserModel(
                        email: email.text,
                        password: password.text.trim(),
                      ),
                    );
                  } else {
                    print('error');
                  }
                },
                child: const ButtomData(
                  colors: Colors.blueAccent,
                  text: 'Create account',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

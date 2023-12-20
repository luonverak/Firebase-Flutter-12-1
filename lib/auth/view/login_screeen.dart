import 'package:firebase_flutter/auth/controller/user_controller.dart';
import 'package:firebase_flutter/auth/model/user_model.dart';
import 'package:firebase_flutter/auth/view/register_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widget/buttons.dart';
import '../widget/input_field.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final email = TextEditingController();
  final password = TextEditingController();
  final controller = Get.put(UserController());
  RxBool check = true.obs;
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
              const SizedBox(
                height: 100,
              ),
              const Text(
                'Welcome',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 60,
              ),
              InputField(
                controller: email,
                hintText: 'Enter Email',
                prefixIcon: Icons.email,
                obscureText: false,
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => InputField(
                  controller: password,
                  hintText: 'Enter Password',
                  prefixIcon: Icons.lock,
                  suffixIcon: IconButton(
                    onPressed: () async {
                      check.value = !check.value;
                    },
                    icon: check.value == true
                        ? Icon(Icons.visibility_off)
                        : Icon(Icons.remove_red_eye),
                  ),
                  obscureText: check.value,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              GestureDetector(
                onTap: () async {
                  await controller.loginUser(
                    UserModel(
                      email: email.text,
                      password: password.text.trim(),
                    ),
                  );
                },
                child: const ButtomData(
                  colors: Colors.blueAccent,
                  text: 'Login',
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'or',
                style: TextStyle(fontSize: 18),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () async => controller.signInWithGoogle(),
                    child: SizedBox(
                      width: 60,
                      height: 60,
                      child: Image.asset(
                        'asset/icons/new.png',
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'asset/icons/facebook.png',
                    ),
                  ),
                  SizedBox(
                    width: 60,
                    height: 60,
                    child: Image.asset(
                      'asset/icons/twitter.png',
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.only(bottom: 20),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 212, 227, 252),
              Color.fromARGB(255, 212, 227, 252)
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(0.0, 0.1),
          ),
        ),
        child: CupertinoButton(
          child: const Text(
            'Register Account',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          onPressed: () async => Get.to(RegisterScreen()),
        ),
      ),
    );
  }
}

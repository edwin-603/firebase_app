import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_contoller.dart';

class LoginPage extends StatelessWidget {
  final AuthController authController = Get.put(AuthController());

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: "Email"),
              keyboardType: TextInputType.emailAddress,
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
              obscureText: true,
            ),
            SizedBox(height: 20),
            Obx(() {
              return authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () {
                  authController.loginWithEmailAndPassword(
                    emailController.text.trim(),
                    passwordController.text.trim(),
                  );
                },
                child: Text("Login with Email/Password"),
              );
            }),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                authController.signInWithGoogle();
              },
              child: Text("Login with Google"),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                authController.signInWithApple();
              },
              child: Text("Login with Apple"),
            ),
            SizedBox(height: 10),
            TextField(
              controller: phoneController,
              decoration: InputDecoration(labelText: "Phone Number"),
              keyboardType: TextInputType.phone,
            ),
            ElevatedButton(
              onPressed: () {
                authController.loginWithPhoneNumber(phoneController.text.trim());
              },
              child: Text("Login with Phone"),
            ),
            TextButton(
              onPressed: () {
                Get.toNamed('/register');
              },
              child: Text("Don't have an account? Register"),
            ),
          ],
        ),
      ),
    );
  }
}
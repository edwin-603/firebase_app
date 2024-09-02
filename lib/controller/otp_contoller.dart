import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'auth_contoller.dart';

class OTPScreen extends StatelessWidget {
  final String verificationId;
  final TextEditingController otpController = TextEditingController();
  final AuthController authController = Get.put(AuthController());

  OTPScreen({required this.verificationId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Verify OTP")),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: otpController,
              decoration: InputDecoration(labelText: "OTP"),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            Obx(() {
              return authController.isLoading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                onPressed: () async {
                  authController.isLoading.value = true;
                  try {
                    String otp = otpController.text.trim();
                    PhoneAuthCredential credential =
                    PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: otp,
                    );
                    await authController.auth.signInWithCredential(credential);
                    Get.snackbar("Success", "Login successful");
                    Get.offAllNamed('/home');
                  } catch (e) {
                    Get.snackbar("Error", e.toString());
                  } finally {
                    authController.isLoading.value = false;
                  }
                },
                child: Text("Verify OTP"),
              );
            }),
          ],
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/utils/toasty.dart';

class SignupController extends GetxController {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true.obs;

  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void signup() {
    String name = nameController.text.trim();
    String email = emailController.text.trim();
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (name.isEmpty || phone.isEmpty || email.isEmpty || password.isEmpty) {
      Toasty.failed('Please fill all fields');
      return;
    }
    Toasty.success('Account created for $name');
    Get.offAll(() => Dashboard());
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

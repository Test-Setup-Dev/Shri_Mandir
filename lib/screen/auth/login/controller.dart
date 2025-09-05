import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/dashboard/dashboard_screen.dart';
import 'package:mandir/screen/home/home.dart';
import 'package:mandir/utils/toasty.dart';

class LoginController extends GetxController {
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  var obscurePassword = true.obs;

  @override
  void onInit() {
    phoneController.text = '9876543210';
    passwordController.text = 'password';
    super.onInit();
  }
  void togglePasswordVisibility() {
    obscurePassword.value = !obscurePassword.value;
  }

  void login() {
    String phone = phoneController.text.trim();
    String password = passwordController.text.trim();

    if (phone.isEmpty || password.isEmpty) {
      Toasty.failed('Please fill all fields');
      return;
    }
    Toasty.success('Logged in with $phone');
    Get.offAll(() => Dashboard());
  }
}

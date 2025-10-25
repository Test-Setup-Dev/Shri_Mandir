import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mandir/screen/auth/reset_pass/reset_pass_screen.dart';


// Controller
class ResetPasswordController extends GetxController {
  final emailController = TextEditingController();
  final otpController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var isConfirmPasswordVisible = false.obs;
  var errorMessage = ''.obs;

  final dio = Dio();

  // Constructor with optional email parameter
  ResetPasswordController({String? email}) {
    if (email != null) {
      emailController.text = email;
    }
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  Future<void> resetPassword() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      var headers = {
        'Content-Type': 'application/json'
      };

      var data = json.encode({
        "email": emailController.text.trim(),
        "otp": otpController.text.trim(),
        "password": passwordController.text,
        "password_confirmation": confirmPasswordController.text
      });

      var response = await dio.request(
        'https://test.pearl-developer.com/anuweb/public/api/reset-Password',
        options: Options(
          method: 'POST',
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200) {
        Get.snackbar(
          'Success',
          'Password reset successfully',
          backgroundColor: AppTheme.success,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          icon: const Icon(Icons.check_circle, color: Colors.white),
          margin: const EdgeInsets.all(AppTheme.spacing),
          borderRadius: AppTheme.borderRadius,
        );

        // Navigate back to login or home
        Get.offAllNamed('/login'); // Update with your route
      } else {
        errorMessage.value = response.statusMessage ?? 'Something went wrong';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage.value = e.response?.data['message'] ?? 'Failed to reset password';
      } else {
        errorMessage.value = 'Network error. Please check your connection';
      }
    } catch (e) {
      errorMessage.value = 'An unexpected error occurred';
    } finally {
      isLoading.value = false;
    }
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateOTP(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter OTP';
    }
    if (value.length != 6) {
      return 'OTP must be 6 digits';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }
    return null;
  }

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  void onClose() {
    emailController.dispose();
    otpController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:mandir/data_handler/repository.dart';
import 'package:mandir/screen/auth/reset_pass/reset_pass_screen.dart';
import 'package:mandir/utils/toasty.dart';

// Controller
class ForgetPasswordController extends GetxController {
  final emailController = TextEditingController(
    text: 'testsetup.dev@gmail.com',
  );
  final formKey = GlobalKey<FormState>();

  var isLoading = false.obs;
  var errorMessage = ''.obs;

  final dio = Dio();

  Future<void> sendResetLink() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';
      final response = await Repository.instance.forgetPassword(
        'testsetup.dev@gmail.com',
      );

      Get.to(()=> ResetPasswordScreen());
      if (response.statusCode == 200 && response['status'] == true) {
        Toasty.success('Password reset OTP sent to your email');
        emailController.clear();
      } else {
        errorMessage.value = response.statusMessage ?? 'Something went wrong';
      }
    } on DioException catch (e) {
      if (e.response != null) {
        errorMessage.value =
            e.response?.data['message'] ?? 'Failed to send reset link';
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

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}

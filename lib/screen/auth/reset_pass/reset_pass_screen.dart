import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mandir/screen/auth/reset_pass/controller.dart';
import 'package:mandir/utils/helper.dart';

// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final bool readOnly;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLength;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.maxLength,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ThemeColors.white,
        borderRadius: BorderRadius.circular(4.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        validator: validator,
        maxLength: maxLength,
        readOnly: readOnly,
        style: TextStyle(
          fontSize: 4.w,
          fontWeight: FontWeight.w500,
          color: ThemeColors.defaultTextColor,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: TextStyle(color: ThemeColors.textPrimaryColor),
          prefixIcon: Icon(
            prefixIcon,
            color: ThemeColors.primaryColor,
            size: 6.w,
          ),
          suffixIcon: suffixIcon,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w),
            borderSide: BorderSide(color: ThemeColors.primaryColor, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w),
            borderSide: BorderSide(color: ThemeColors.accentColor, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4.w),
            borderSide: BorderSide(color: ThemeColors.accentColor, width: 2),
          ),
          filled: true,
          fillColor: ThemeColors.white,
        ),
      ),
    );
  }
}

// Reset Password Screen
class ResetPasswordScreen extends StatelessWidget {
  final String? email;

  const ResetPasswordScreen({super.key, this.email});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController(email: email));

    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: ThemeColors.primaryColor,
        elevation: 0,
        title: Text('Reset Password', style: TextStyle(fontSize: 5.w),),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: ThemeColors.white,
            size: 6.w,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(6.w),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 7.w),

                // Title
                Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 8.w,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: ThemeColors.defaultTextColor,
                  ),
                ),

                SizedBox(height: 3.w),

                // Subtitle
                Text(
                  'Enter the OTP sent to your email and create a new password',
                  style: TextStyle(
                    fontSize: 4.w,
                    color: ThemeColors.textPrimaryColor,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 10.w),

                // OTP Field
                CustomTextField(
                  controller: controller.otpController,
                  label: 'OTP',
                  prefixIcon: Icons.verified_user_outlined,
                  keyboardType: TextInputType.number,
                  validator: controller.validateOTP,
                  maxLength: 6,
                ),

                SizedBox(height: 4.w),

                // Password Field
                Obx(
                  () => CustomTextField(
                    controller: controller.passwordController,
                    label: 'New Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: !controller.isPasswordVisible.value,
                    validator: controller.validatePassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ThemeColors.textPrimaryColor,
                        size: 6.w,
                      ),
                      onPressed: controller.togglePasswordVisibility,
                    ),
                  ),
                ),

                SizedBox(height: 4.w),

                // Confirm Password Field
                Obx(
                  () => CustomTextField(
                    controller: controller.confirmPasswordController,
                    label: 'Confirm Password',
                    prefixIcon: Icons.lock_outline,
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    validator: controller.validateConfirmPassword,
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isConfirmPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: ThemeColors.textPrimaryColor,
                        size: 6.w,
                      ),
                      onPressed: controller.toggleConfirmPasswordVisibility,
                    ),
                  ),
                ),


                40.vs,

                // Submit Button
                Obx(
                  () => SizedBox(
                    width: double.infinity,
                    height: 14.w,
                    child: ElevatedButton(
                      onPressed:
                          controller.isLoading.value
                              ? null
                              : controller.resetPassword,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeColors.primaryColor,
                        foregroundColor: ThemeColors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.w),
                        ),
                        disabledBackgroundColor: ThemeColors.greyColor
                            .withOpacity(0.3),
                      ),
                      child:
                          controller.isLoading.value
                              ? SizedBox(
                                width: 6.w,
                                height: 6.w,
                                child: CircularProgressIndicator(
                                  color: ThemeColors.white,
                                  strokeWidth: 2.5,
                                ),
                              )
                              : Text(
                                'Reset Password',
                                style: TextStyle(
                                  fontSize: 4.w,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.5,
                                ),
                              ),
                    ),
                  ),
                ),

                SizedBox(height: 6.w),

                // Resend OTP
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Handle resend OTP
                    },
                    child: Text(
                      'Didn\'t receive OTP? Resend',
                      style: TextStyle(
                        color: ThemeColors.primaryColor,
                        fontSize: 3.5.w,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

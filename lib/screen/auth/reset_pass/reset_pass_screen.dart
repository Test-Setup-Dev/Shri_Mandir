import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'dart:convert';

import 'package:mandir/screen/auth/reset_pass/controller.dart';


class AppTheme {
  // Colors
  static const Color primary = Color(0xFF2563EB);
  static const Color primaryDark = Color(0xFF1E40AF);
  static const Color secondary = Color(0xFF10B981);
  static const Color background = Color(0xFFF8F9FA);
  static const Color cardBackground = Colors.white;
  static const Color textPrimary = Color(0xFF1A1A1A);
  static const Color textSecondary = Color(0xFF6B7280);
  static const Color error = Color(0xFFEF4444);
  static const Color success = Color(0xFF10B981);

  // Sizes
  static const double borderRadius = 16.0;
  static const double cardElevation = 8.0;
  static const double spacing = 16.0;
  static const double spacingLarge = 24.0;
  static const double buttonHeight = 56.0;
  static const double iconSize = 24.0;
}


// Custom Text Field Widget
class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final IconData prefixIcon;
  final bool obscureText;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final int? maxLength;

  const CustomTextField({
    Key? key,
    required this.controller,
    required this.label,
    required this.prefixIcon,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.validator,
    this.suffixIcon,
    this.maxLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppTheme.cardBackground,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
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
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppTheme.textPrimary,
        ),
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: AppTheme.textSecondary),
          prefixIcon: Icon(prefixIcon, color: AppTheme.primary),
          suffixIcon: suffixIcon,
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: const BorderSide(color: AppTheme.primary, width: 2),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: const BorderSide(color: AppTheme.error, width: 2),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppTheme.borderRadius),
            borderSide: const BorderSide(color: AppTheme.error, width: 2),
          ),
          filled: true,
          fillColor: AppTheme.cardBackground,
        ),
      ),
    );
  }
}

// Reset Password Screen
class ResetPasswordScreen extends StatelessWidget {
  final String? email;

  const ResetPasswordScreen({Key? key, this.email}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ResetPasswordController(email: email));

    return Scaffold(
      backgroundColor: AppTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppTheme.textPrimary),
          onPressed: () => Get.back(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppTheme.spacingLarge),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Icon
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppTheme.primary, AppTheme.primaryDark],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.3),
                        blurRadius: 20,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.lock_reset_rounded,
                    size: 40,
                    color: Colors.white,
                  ),
                ),

                const SizedBox(height: 30),

                // Title
                const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1,
                    color: AppTheme.textPrimary,
                  ),
                ),

                const SizedBox(height: 12),

                // Subtitle
                const Text(
                  'Enter the OTP sent to your email and create a new password',
                  style: TextStyle(
                    fontSize: 16,
                    color: AppTheme.textSecondary,
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 40),

                // Email Field
                CustomTextField(
                  controller: controller.emailController,
                  label: 'Email Address',
                  prefixIcon: Icons.email_outlined,
                  keyboardType: TextInputType.emailAddress,
                  validator: controller.validateEmail,
                ),

                const SizedBox(height: AppTheme.spacing),

                // OTP Field
                CustomTextField(
                  controller: controller.otpController,
                  label: 'OTP',
                  prefixIcon: Icons.verified_user_outlined,
                  keyboardType: TextInputType.number,
                  validator: controller.validateOTP,
                  maxLength: 6,
                ),

                const SizedBox(height: AppTheme.spacing),

                // Password Field
                Obx(() => CustomTextField(
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
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                )),

                const SizedBox(height: AppTheme.spacing),

                // Confirm Password Field
                Obx(() => CustomTextField(
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
                      color: AppTheme.textSecondary,
                    ),
                    onPressed: controller.toggleConfirmPasswordVisibility,
                  ),
                )),

                const SizedBox(height: AppTheme.spacing),

                // Error Message
                Obx(() {
                  if (controller.errorMessage.value.isNotEmpty) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: AppTheme.error.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppTheme.error.withOpacity(0.3)),
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.error_outline, color: AppTheme.error),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              controller.errorMessage.value,
                              style: const TextStyle(
                                color: AppTheme.error,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                }),

                const SizedBox(height: 30),

                // Submit Button
                Obx(() => SizedBox(
                  width: double.infinity,
                  height: AppTheme.buttonHeight,
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : controller.resetPassword,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
                      ),
                      disabledBackgroundColor: Colors.grey.shade300,
                    ),
                    child: controller.isLoading.value
                        ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2.5,
                      ),
                    )
                        : const Text(
                      'Reset Password',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                )),

                const SizedBox(height: 24),

                // Resend OTP
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Handle resend OTP
                    },
                    child: const Text(
                      'Didn\'t receive OTP? Resend',
                      style: TextStyle(
                        color: AppTheme.primary,
                        fontSize: 14,
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
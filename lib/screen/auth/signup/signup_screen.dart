import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/auth/login/login_screen.dart';
import 'package:mandir/screen/auth/signup/controller.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/gender_button.dart';
import 'package:mandir/widget/widgets.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final controller = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: ListView(
            children: [
              5.h.vs,
              _buildLogo(),
              5.h.vs,

              Text(
                "Create an Account",
                style: TextStyle(
                  fontSize: 7.w,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.defaultTextColor,
                ),
              ),
              1.h.vs,
              Text(
                "Sign up for an exceptional experience",
                style: TextStyle(
                  fontSize: 4.w,
                  color: ThemeColors.textPrimaryColor,
                ),
              ),
              5.h.vs,
              // Full Name
              CustomTextField(
                controller: controller.nameCtrl,
                hintText: "Full Name",
                keyboardType: TextInputType.text,
              ),
              1.h.vs,

              // Phone/Email
              CustomTextField(
                controller: controller.emailCtrl,
                hintText: "Email",
                keyboardType: TextInputType.emailAddress,
              ),

              1.h.vs,

              // Phone
              CustomTextField(
                controller: controller.phoneCtrl,
                hintText: "Phone",
                keyboardType: TextInputType.number,
              ),
              1.h.vs,

              // Password
              Obx(
                () => CustomTextField(
                  controller: controller.passwordCtrl,
                  hintText: "Password",
                  obscureText: controller.obscurePassword.value,
                  suffixIcon: IconButton(
                    icon: Icon(
                      controller.obscurePassword.value
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: ThemeColors.textPrimaryColor,
                    ),
                    onPressed: controller.togglePasswordVisibility,
                  ),
                ),
              ),

              // 1.h.vs,
              // GenderToggleButton(),
              4.h.vs,

              CustomButton(text: "Sign Up", onPressed: controller.signup),
              4.h.vs,

              _buildDivider(),
              3.h.vs,

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SocialButton(icon: 'assets/icons/facebook.png', onTap: () {}),
                  SocialButton(icon: 'assets/icons/google.png', onTap: () {}),
                  SocialButton(icon: 'assets/icons/apple.png', onTap: () {}),
                ],
              ),
              5.h.vs,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Already have an account? ",
                    style: TextStyle(color: ThemeColors.textPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.off(LoginScreen()),
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: ThemeColors.primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              5.h.vs,
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Row(
      children: [
        Container(
          width: 10.w,
          height: 10.w,
          decoration: BoxDecoration(
            color: ThemeColors.purple.withAlpha(150),
            borderRadius: BorderRadius.circular(2.w),
            image: DecorationImage(image: AssetImage('assets/icons/logo.png')),
          ),
        ),
        2.w.hs,
        Text(
          'appName'.t,
          style: TextStyle(
            fontSize: 5.w,
            fontWeight: FontWeight.w600,
            color: ThemeColors.defaultTextColor,
          ),
        ),
      ],
    );
  }

  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: ThemeColors.greyColor.withOpacity(0.3))),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 4.w),
          child: Text(
            "or",
            style: TextStyle(color: ThemeColors.textPrimaryColor),
          ),
        ),
        Expanded(child: Divider(color: ThemeColors.greyColor.withOpacity(0.3))),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mandir/screen/auth/login/controller.dart';
import 'package:mandir/screen/auth/signup/signup_screen.dart';
import 'package:mandir/utils/helper.dart';
import 'package:mandir/widget/widgets.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ThemeColors.backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.w),
          child: ListView(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              5.h.vs,
              _buildLogo(),
              5.h.vs,
              Text(
                "Welcome Back!",
                style: TextStyle(
                  fontSize: 7.w,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors.defaultTextColor,
                ),
              ),
              1.h.vs,
              Text(
                "Sign in to continue your journey",
                style: TextStyle(
                  fontSize: 4.w,
                  color: ThemeColors.textPrimaryColor,
                ),
              ),
              5.h.vs,

              // Phone/Email
              CustomTextField(
                controller: controller.emailCtrl,
                hintText: "Phone/Email",
                keyboardType: TextInputType.emailAddress,
              ),
              1.h.vs,

              // Password
              Obx(
                () => CustomTextField(
                  controller: controller.passCtrl,
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
              1.h.vs,

              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {},
                  child: Text(
                    "Forgotten Password?",
                    style: TextStyle(
                      color: ThemeColors.primaryColor,
                      fontSize: 3.5.w,
                    ),
                  ),
                ),
              ),
              16.h.vs,

              CustomButton(
                text: "Sign In",
                onPressed:
                    () => controller.login(
                      controller.emailCtrl.text,
                      controller.passCtrl.text,
                    ),
              ),
              5.h.vs,

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
              6.h.vs,

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account? ",
                    style: TextStyle(color: ThemeColors.textPrimaryColor),
                  ),
                  GestureDetector(
                    onTap: () => Get.off(SignUpScreen()),
                    child: Text(
                      "Sign Up",
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
          width: 8.w,
          height: 8.w,
          decoration: BoxDecoration(
            color: ThemeColors.primaryColor,
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: Center(
            child: Text(
              "L",
              style: TextStyle(
                color: ThemeColors.white,
                fontSize: 4.5.w,
                fontWeight: FontWeight.bold,
              ),
            ),
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

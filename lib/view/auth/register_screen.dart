import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/auth/account_verification_screen.dart';
import 'package:samaj_parivaar_app/view/auth/login_page.dart';
import 'package:samaj_parivaar_app/widgets/app_text_form_field.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final authController = Get.find<AuthController>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final obscure = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 85.h, 30.w, 0),
        child: Column(
          spacing: 10,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Let's get\nStarted",
              style: appTheme().textTheme.headlineLarge?.copyWith(
                color: MyAppColors.lavender,
              ),
            ),
            SizedBox(height: 20.h),
            AppTextFormField(
              hintText: "Full Name",
              controller: fullNameController,
              prefixIcon: Image.asset(AssetsRes.NAME, scale: 3.0),
            ),
            AppTextFormField(
              hintText: "Email id",
              controller: emailController,
              prefixIcon: Image.asset(AssetsRes.EMAIL, scale: 3.0),
            ),
            AppTextFormField(
              hintText: "Password",
              controller: passwordController,
              prefixIcon: Image.asset(AssetsRes.PASSWORD_LOCK, scale: 3.0),
              obscureNotifier: obscure,
            ),
            AppTextFormField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              prefixIcon: Image.asset(AssetsRes.PASSWORD_LOCK, scale: 3.0),
              obscureNotifier: obscure,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot password?",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontSize: 12.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            signUpOrContinueColumn(),
          ],
        ),
      ),
    );
  }

  Widget signUpOrContinueColumn() {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () async {
              if (await authController.register(
                fullNameController.text,
                emailController.text,
                passwordController.text,
              )) {
                Get.offAll(() => AccountVerificationScreen());
              }
            },
            child: (authController.isLoading.value)
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    newHeight: 50.h,
                    newWidth: 350.w,
                    text: "Sign Up",
                    borderRadius: BorderRadius.circular(35),
                    style: TextStyle(
                      fontSize: 15.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
          );
        }),
        Text(
          "or continue with",
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontSize: 15.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
        GestureDetector(
          child: Container(
            height: 50.h,
            width: 350.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.r),
              border: Border.all(color: MyAppColors.lavender),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(AssetsRes.GOOGLE, height: 30.h, width: 30.w),
                SizedBox(width: 10.h),
                Text(
                  "Google",
                  style: appTheme().textTheme.bodyLarge?.copyWith(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                    fontSize: 20.sp,
                  ),
                ),
              ],
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => LoginPage());
              },
              child: Text(
                "Login",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

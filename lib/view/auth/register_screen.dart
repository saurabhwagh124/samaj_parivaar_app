import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/auth/account_verification_screen.dart';
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
                color: appTheme().colorScheme.lavender,
              ),
            ),
            SizedBox(height: 20.h),
            AppTextFormField(
              hintText: "Full Name",
              controller: emailController,
              prefixIcon: CupertinoIcons.person,
            ),
            AppTextFormField(
              hintText: "Email id",
              controller: emailController,
              prefixIcon: CupertinoIcons.mail,
            ),
            AppTextFormField(
              hintText: "Password",
              controller: passwordController,
              prefixIcon: CupertinoIcons.lock,
              obscureNotifier: obscure,
            ),
            AppTextFormField(
              hintText: "Confirm Password",
              controller: confirmPasswordController,
              prefixIcon: CupertinoIcons.lock,
              obscureNotifier: obscure,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  "Forgot password?",
                  textAlign: TextAlign.right,
                  style: Theme.of(context).textTheme.bodyLarge,
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
                    newHeight: 70.h,
                    newWidth: 360.w,
                    text: "SignUp",
                    borderRadius: BorderRadius.circular(35),
                  ),
          );
        }),
        Text(
          "or continue with",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 20.sp),
        ),
        GestureDetector(
          child: Container(
            height: 70.h,
            width: 360.w,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(35.r),
              border: Border.all(color: Theme.of(context).colorScheme.lavender),
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
              child: Text(
                "Sign up",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

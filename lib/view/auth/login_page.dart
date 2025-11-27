import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/auth/register_screen.dart';
import 'package:samaj_parivaar_app/view/landing/landing_page.dart';
import 'package:samaj_parivaar_app/widgets/app_text_form_field.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final authController = Get.find<AuthController>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final obscure = ValueNotifier(true);

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 85.h, 30.w, 25.h),
        child: Column(
          spacing: 10.h,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hey\nWelcome Back",
              style: appTheme().textTheme.headlineLarge?.copyWith(
                color: MyAppColors.lavender,
                fontSize: 36.sp,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: 20.h),
            AppTextFormField(
              hintText: "Email id",
              controller: emailController,
              prefixIcon: Image.asset(AssetsRes.EMAIL, scale: 3.0),
            ),
            SizedBox(height: 10.h),
            AppTextFormField(
              hintText: "Password",
              controller: passwordController,
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
            loginOrContinueColumn(),
          ],
        ),
      ),
    );
  }

  Widget loginOrContinueColumn() {
    return Column(
      spacing: 20.h,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Obx(() {
          return GestureDetector(
            onTap: () async {
              if (await authController.login(
                emailController.text,
                passwordController.text,
              )) {
                Get.offAll(() => LandingPage());
              }
            },
            child: (authController.isLoading.value)
                ? const Center(child: CircularProgressIndicator())
                : PrimaryButton(
                    newHeight: 50.h,
                    newWidth: 350.w,
                    text: "Login",
                    borderRadius: BorderRadius.circular(35.r),
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                      color: Colors.white,
                    ),
                  ),
          );
        }),
        Text(
          "or continue with",
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontSize: 15.sp),
        ),
        GestureDetector(
          child: Container(
            height: 50.h,
            width: 350.w,
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
                SizedBox(width: 10.w),
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
              "Don't have an account? ",
              style: Theme.of(context).textTheme.titleSmall,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => RegisterScreen());
              },
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

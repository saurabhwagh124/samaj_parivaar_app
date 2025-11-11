import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class AccountVerificationScreen extends StatefulWidget {
  const AccountVerificationScreen({super.key});

  @override
  State<AccountVerificationScreen> createState() =>
      _AccountVerificationScreenState();
}

class _AccountVerificationScreenState extends State<AccountVerificationScreen> {
  final pinputController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.fromLTRB(30.w, 85.h, 30.w, 0.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 10.h,
          children: [
            Row(
              children: [
                Text(
                  "Account\nVerification",
                  style: appTheme().textTheme.headlineLarge?.copyWith(
                    color: appTheme().colorScheme.lavender,
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
            SizedBox(height: 70.h),
            Text(
              "Please enter the code we have just sent to your phone",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w400),
            ),
            Text(
              "+91 XXXXXXXX01",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: appTheme().colorScheme.lavender,
              ),
            ),
            Pinput(
              controller: pinputController,
              length: 4,
              defaultPinTheme: PinTheme(
                height: 45.h,
                width: 51.w,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.r),
                  border: Border.all(color: appTheme().colorScheme.lavender),
                ),
              ),
            ),
            SizedBox(height: 25.h),
            Text(
              "Didn't receive OTP?",
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
            ),
            Text(
              "Resend code",
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
                color: appTheme().colorScheme.lavender,
              ),
            ),
            SizedBox(height: 40.h),
            PrimaryButton(
              newHeight: 70.h,
              newWidth: 350.w,
              text: "Verify",
              borderRadius: BorderRadius.circular(10.r),
            ),
          ],
        ),
      ),
    );
  }
}

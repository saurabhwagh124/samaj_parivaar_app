import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/auth/login_page.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding:  EdgeInsets.all(10.sp),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Center(
              child: Container(
                margin: EdgeInsets.only(top: 75.h),
                height: 330.h,
                width: 360.w,
                child: Image.asset("assets/images/community_people.png"),
              ),
            ),
            SizedBox(height: 24.h),
            Center(
              child: Column(
                children: [
                  Text(
                    "Social Community",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.lavender,
                    ),
                  ),
                  Text(
                    "Team",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                      color: Theme.of(context).colorScheme.lavender,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 25.h),
            Padding(
              padding:  EdgeInsets.all(20.sp),
              child: Text(
                " Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged.",
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.bodyMedium,
                textDirection: TextDirection.ltr,
              ),
            ),
            SizedBox(height: 20.h),
            Spacer(),
            Container(
              height: 50.h,
              width: 350.w,
              decoration: BoxDecoration(
                color: appTheme().colorScheme.iceBlue,
                borderRadius: BorderRadius.circular(35),
              ),
              child: Stack(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LoginPage()),
                      );
                    },
                    child: Container(
                      height: 50.h,
                      width: 150.w,
                      decoration: BoxDecoration(
                        color: appTheme().colorScheme.lavender,
                        borderRadius: BorderRadius.circular(35),
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "Login",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: Colors.white, fontSize: 20.sp, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 50.w),
                        alignment: Alignment.center,
                        child: Text(
                          "Sign Up",
                          style: Theme.of(context).textTheme.headlineSmall
                              ?.copyWith(
                                color: appTheme().colorScheme.lavender,
                            fontSize: 20.sp, fontWeight: FontWeight.w600
                              ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: 66.h),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class CreateCommunityPage extends StatelessWidget {
  const CreateCommunityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 180.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: double.infinity),
            CircleAvatar(backgroundColor: Colors.grey[300], radius: 95.r),
            SizedBox(height: 10.h),
            Text(
              "Parivaar",
              style: appTheme().textTheme.headlineSmall?.copyWith(
                color: MyAppColors.lavender,
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              "You can either create your own\ncommunity or join a community ",
              textAlign: TextAlign.center,
              style: appTheme().textTheme.bodyLarge?.copyWith(fontSize: 20.sp),
            ),
            SizedBox(height: 30.h),
            SecondaryButton(
              newHeight: 60.h,
              newWidth: 350.w,
              text: "Create your community",
              borderRadius: BorderRadius.circular(15.r),
            ),
            SizedBox(height: 20.h),
            SecondaryButton(
              newHeight: 60.h,
              newWidth: 350.w,
              text: "Join community",
              borderRadius: BorderRadius.circular(15.r),
            ),
          ],
        ),
      ),
    );
  }
}

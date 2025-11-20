import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/user.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/view/auth/basic_form_screen.dart';
import 'package:samaj_parivaar_app/view/auth/login_page.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user; // nullable
  bool _loading = true; // loading guard

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final data = await LocalStorage.i.getUser("current_user");
    if (mounted) {
      setState(() {
        user = data.isNotEmpty ? User.fromJson(jsonDecode(data)) : null;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading || user == null) {
      return const Center(child: CircularProgressIndicator()); // or empty box
    }

    return _buildContent(); // non-null user here
  }

  Widget _buildContent() {
    return Scaffold(
      appBar: CommonAppbar(titleText: "My Profile", actionsList: []),
      body: Padding(
        padding: EdgeInsets.only(
          left: 30.w,
          right: 30.w,
          top: 30.h,
          bottom: 30.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                MyNetworkImage.networkImage(
                  70.r,
                  user!.profilePhotoUrl ?? "",
                  BoxFit.contain,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: EdgeInsets.all(5.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: appTheme().colorScheme.lavender,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt_outlined,
                      color: appTheme().colorScheme.lavender,
                      size: 25.sp,
                    ),
                  ),
                ),
              ],
            ),
            Text(
              user!.fullName ?? " USER ",
              style: appTheme().textTheme.headlineSmall?.copyWith(
                color: appTheme().colorScheme.lavender,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              user!.bio ?? "Lorem Ipsum is simply dummy text",
              style: appTheme().textTheme.titleMedium,
            ),
            SizedBox(height: 10.h),
            InkWell(
              onTap: () {
                Get.to(() => BasicFormScreen(isEdit: true));
              },
              child: SecondaryButton(
                newHeight: 38.h,
                newWidth: 366.w,
                text: "Edit Profile",
                borderRadius: BorderRadius.circular(5.r),
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 15.sp,
                  color: appTheme().colorScheme.lavender,
                ),
              ),
            ),
            SizedBox(height: 20.h),
            TextButton(
              onPressed: () async {
                await LocalStorage.i.clear();
                Get.offAll(() => LoginPage());
              },
              child: Text("Logout"),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

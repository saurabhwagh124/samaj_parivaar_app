import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final bool showLeadingIcon;
  final String titleText;
  final bool? center;
  final List<Widget> actionsList;
  final TextStyle? style;

  const CommonAppbar({
    super.key,
    this.showLeadingIcon = true,
    required this.titleText,
    this.center = false,
    required this.actionsList,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: MyAppColors.iceBlue,
      leading: (showLeadingIcon)
          ? IconButton(
              icon: const Icon(Icons.arrow_back_ios),
              iconSize: 20.sp,
              color: MyAppColors.lavender,
              onPressed: () {
                Get.back();
              },
            )
          : null,

      centerTitle: center,

      title: Text(
        titleText,
        style:
            style ??
            TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: MyAppColors.lavender,
            ),
      ),

      actions: actionsList,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

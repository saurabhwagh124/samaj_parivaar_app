import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class CommonAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final bool? center;
  final List<Widget> actionsList;
  final TextStyle? style;

  const CommonAppbar({
    super.key,
    required this.titleText,
    this.center = false,
    required this.actionsList,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: appTheme().colorScheme.iceBlue,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        iconSize: 20.sp,
        color: appTheme().colorScheme.lavender,
        onPressed: () {
          Get.back();
        },
      ),

      centerTitle: center,

      title: Text(
        titleText,
        style:
            style ??
            TextStyle(
              fontSize: 24.sp,
              fontWeight: FontWeight.w600,
              color: appTheme().colorScheme.lavender,
            ),
      ),

      actions: actionsList,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}

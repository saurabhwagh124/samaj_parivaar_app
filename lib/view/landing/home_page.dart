import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: MyAppColors.iceBlue,
        leading: Icon(
          Icons.menu,
          size: 32.r,
          color: MyAppColors.lavender,
        ),
        actions: [
          Badge(
            alignment: Alignment.topRight,
            label: Text(""),
            child: IconButton(
              onPressed: () {},
              icon: Icon(
                CupertinoIcons.bell,
                size: 32.sp,
                color: MyAppColors.lavender,
              ),
            ),
          ),
          SizedBox(width: 20.w),
        ],
      ),
    );
  }
}

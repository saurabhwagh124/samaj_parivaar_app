import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/community_controller.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';
import 'package:samaj_parivaar_app/widgets/secondary_button.dart';

class CommunityJoinRequestScreen extends StatefulWidget {
  final CommunityModel data;

  const CommunityJoinRequestScreen({super.key, required this.data});

  @override
  State<CommunityJoinRequestScreen> createState() =>
      _CommunityJoinRequestScreenState();
}

class _CommunityJoinRequestScreenState
    extends State<CommunityJoinRequestScreen> {
  final messageController = TextEditingController();
  final communityController = Get.find<CommunityController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CommonAppbar(titleText: '', actionsList: []),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 25.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MyNetworkImage.networkImageCircleAvatar(
              61.r,
              widget.data.coverPhotoUrl ?? "",
              BoxFit.cover,
            ),
            SizedBox(height: 20.h),
            Text(
              widget.data.groupName ?? "",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: MyAppColors.lavender,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 10.w,
              children: [
                SizedBox(
                  width: 21.w,
                  height: 15.h,
                  child: Image.asset(AssetsRes.COMMUNITY),
                ),
                Text(
                  "${widget.data.memberCount} Members",
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                    color: MyAppColors.textGrey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: MyAppColors.lavender),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    color: Colors.black26,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Text(
                      "Group Description",
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w600,
                        color: MyAppColors.lavender,
                      ),
                    ),
                  ),
                  Divider(color: MyAppColors.lavender),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 20.w,
                      vertical: 10.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.data.locationArea ?? "",
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                            color: MyAppColors.textGrey,
                          ),
                        ),
                        Flexible(
                          child: Text(
                            widget.data.groupDescription ?? "",
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w400,
                              color: MyAppColors.lavender,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10.r),
                border: Border.all(color: MyAppColors.lavender),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 4),
                    color: Colors.black26,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Message to Admin (Optional)",
                    style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.w600,
                      color: MyAppColors.lavender,
                    ),
                  ),
                  TextFormField(
                    controller: messageController,
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: InputBorder.none,
                    ),
                    maxLines: 3,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            InkWell(
              onTap: () {
                communityController.createJoinRequest(
                  widget.data.groupId!,
                  messageController.text,
                );
              },
              child: SecondaryButton(
                newHeight: 58.h,
                newWidth: 384.w,
                text: "Request to join",
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                  color: MyAppColors.lavender,
                ),
                newShadow: [
                  BoxShadow(
                    blurRadius: 7.7,
                    offset: Offset(0, 4),
                    color: Colors.black26,
                  ),
                ],
                newBorder: Border.all(color: MyAppColors.textGrey),
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

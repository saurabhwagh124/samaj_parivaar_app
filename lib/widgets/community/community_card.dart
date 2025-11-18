import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/community/community_join_request_screen.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class CommunityCard extends StatefulWidget {
  final CommunityModel data;
  final bool isJoined;

  const CommunityCard({super.key, required this.data, this.isJoined = false});

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 15.h),
      decoration: BoxDecoration(
        color: appTheme().colorScheme.iceBlue,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            blurRadius: 7.7,
            offset: Offset(0, 4),
            spreadRadius: 0,
            color: Color(0x2D000000),
          ),
        ],
      ),
      height: 150.h,
      width: 360.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.data.groupName ?? "Name",
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: appTheme().colorScheme.lavender,
            ),
          ),
          Text(
            widget.data.locationArea ?? "Location",
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w400,
              color: appTheme().colorScheme.textGrey,
            ),
          ),
          Expanded(
            child: Text(
              widget.data.groupDescription ?? "Description",
              style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.w400),
            ),
          ),
          Row(
            children: [
              Text(
                "${widget.data.memberCount} Members",
                style: TextStyle(
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w400,
                  color: appTheme().colorScheme.textGrey,
                ),
              ),
              Spacer(),
              (widget.isJoined)
                  ? SizedBox.shrink()
                  : GestureDetector(
                      onTap: () {
                        Get.to(
                          () => CommunityJoinRequestScreen(data: widget.data),
                        );
                      },
                      child: PrimaryButton(
                        newHeight: 30.h,
                        newWidth: 99.w,
                        text: "Join Request",
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        borderRadius: BorderRadius.circular(30.r),
                      ),
                    ),
            ],
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';
import 'package:samaj_parivaar_app/widgets/primary_button.dart';

class CommunityGridBox extends StatefulWidget {
  final CommunityModel data;

  const CommunityGridBox({super.key, required this.data});

  @override
  State<CommunityGridBox> createState() => _CommunityGridBoxState();
}

class _CommunityGridBoxState extends State<CommunityGridBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.all(5.r),
      padding: EdgeInsets.all(10.r),
      decoration: BoxDecoration(
        color: MyAppColors.grey1,
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          MyNetworkImage.networkImageCircleAvatar(
            35.r,
            widget.data.coverPhotoUrl ?? "",
            BoxFit.cover,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.person_outline),
              Text("${widget.data.memberCount}"),
            ],
          ),
          SizedBox(height: 5.h),
          Expanded(child: Text("${widget.data.groupName}")),
          PrimaryButton(
            newHeight: 40.h,
            newWidth: 150.w,
            text: "Join Community",
            borderRadius: BorderRadius.circular(30.r),
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

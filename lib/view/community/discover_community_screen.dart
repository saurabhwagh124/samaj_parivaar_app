import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/community_controller.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/widgets/app_text_form_field.dart';
import 'package:samaj_parivaar_app/widgets/community/community_card.dart';

class DiscoverCommunityScreen extends StatefulWidget {
  const DiscoverCommunityScreen({super.key});

  @override
  State<DiscoverCommunityScreen> createState() =>
      _DiscoverCommunityScreenState();
}

class _DiscoverCommunityScreenState extends State<DiscoverCommunityScreen> {
  final searchController = TextEditingController();
  RxString search = ''.obs;
  final communityController = Get.find<CommunityController>();

  @override
  void initState() {
    super.initState();
    if (communityController.communities.isEmpty) {
      communityController.getAntiUserCommunities();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          iconSize: 20.sp,
          color: appTheme().colorScheme.lavender,
          onPressed: () {
            Get.back();
          },
        ),
        backgroundColor: appTheme().colorScheme.iceBlue,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 34.h,
              width: 34.w,
              child: Image.asset(AssetsRes.COMMUNITY_ICON, scale: 3.0),
            ),
            SizedBox(width: 15.w),
            Text(
              "Find Your Community",
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.w600,
                color: appTheme().colorScheme.lavender,
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.h),
        child: Column(
          children: [
            AppTextFormField(
              onChangeFunction: (searched) {
                search.value = searched;
              },
              prefixIcon: Icon(
                CupertinoIcons.search,
                color: appTheme().colorScheme.lavender,
              ),
              hintText: 'Search for an area(e.g. Kothrud, Hinjewadi, ...) ',
              hintTextStyle: TextStyle(
                fontSize: 14.sp,
                fontWeight: FontWeight.w400,
                color: appTheme().colorScheme.lavender,
              ),
              radius: BorderRadius.circular(10.r),
              controller: searchController,
            ),
            SizedBox(height: 20.h),
            Expanded(
              child: Obx(() {
                final isLoading =
                    communityController.isCommunitiesLoading.value;
                final communityList = communityController.communities
                    .where(
                      (e) =>
                          e.locationArea!.toLowerCase().contains(
                            search.value.toLowerCase(),
                          ) ||
                          e.groupName!.toLowerCase().contains(
                            search.value.toLowerCase(),
                          ),
                    )
                    .toList();
                return (isLoading)
                    ? Center(child: CircularProgressIndicator())
                    : ListView.separated(
                        itemBuilder: (context, index) =>
                            CommunityCard(data: communityList[index]),
                        separatorBuilder: (context, index) =>
                            SizedBox(height: 20.h),
                        itemCount: communityList.length,
                      );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

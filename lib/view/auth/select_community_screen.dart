import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/controller/community_controller.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/landing/landing_page.dart';
import 'package:samaj_parivaar_app/widgets/community/community_grid_box.dart';

class SelectCommunityScreen extends StatefulWidget {
  const SelectCommunityScreen({super.key});

  @override
  State<SelectCommunityScreen> createState() => _SelectCommunityScreenState();
}

class _SelectCommunityScreenState extends State<SelectCommunityScreen> {
  final searchController = TextEditingController();
  final communityController = Get.find<CommunityController>();

  @override
  void initState() {
    super.initState();
    communityController.getCommunities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(left: 21.w, right: 21.w, top: 90.h),
        child: RefreshIndicator(
          onRefresh: () async {
            communityController.getCommunities();
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: double.infinity),
              Text(
                "Select Community",
                style: appTheme().textTheme.headlineSmall?.copyWith(
                  color: MyAppColors.lavender,
                ),
              ),
              SizedBox(height: 40.h),
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search your community",
                  hintStyle: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w400,
                    color: MyAppColors.lavender,
                  ),
                  suffixIcon: Icon(
                    CupertinoIcons.search,
                    size: 25.sp,
                    color: MyAppColors.lavender,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(color: MyAppColors.lavender),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(6.r),
                    borderSide: BorderSide(color: MyAppColors.lavender),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Obx(() {
                final list = communityController.communities;
                return (communityController.isCommunitiesLoading.value)
                    ? Center(child: CircularProgressIndicator())
                    : Expanded(
                        child: GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 15.h,
                                crossAxisSpacing: 15.w,
                              ),
                          itemBuilder: (context, index) =>
                              CommunityGridBox(data: list[index]),
                          itemCount: list.length,
                        ),
                      );
              }),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.offAll(() => LandingPage());
        },
        shape: CircleBorder(),
        backgroundColor: MyAppColors.iceBlue,
        child: Icon(
          Icons.arrow_forward,
          color: MyAppColors.lavender,
          size: 25.sp,
        ),
      ),
    );
  }
}

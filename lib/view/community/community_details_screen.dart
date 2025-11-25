import 'package:flutter/material.dart';
import 'package:flutter_expandable_fab/flutter_expandable_fab.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/community_model.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/community/create/create_event_screen.dart';
import 'package:samaj_parivaar_app/widgets/common_appbar.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';

class CommunityDetailsScreen extends StatefulWidget {
  final CommunityModel data;

  const CommunityDetailsScreen({super.key, required this.data});

  @override
  State<CommunityDetailsScreen> createState() => _CommunityDetailsScreenState();
}

class _CommunityDetailsScreenState extends State<CommunityDetailsScreen>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  final ValueNotifier<int> _tabIndexNotifier = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _tabIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CommonAppbar(titleText: "", actionsList: [], center: true),
      floatingActionButtonLocation: ExpandableFab.location,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 270.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(6.r),
                  border: Border.all(color: appTheme().colorScheme.lavender),
                ),
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 121.h,
                          child: Image.network(
                            height: 121.h,
                            width: double.infinity,
                            widget.data.coverPhotoUrl ?? "",
                            fit: BoxFit.cover,
                            errorBuilder: (context, _, _) => Image.asset(
                              AssetsRes.ERROR_IMAGE,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Divider(color: appTheme().colorScheme.lavender),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: 15.w,
                              right: 15.w,
                              bottom: 10.h,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 25.h),
                                Row(
                                  children: [
                                    Text(
                                      widget.data.groupName ?? "",
                                      style: TextStyle(
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                        color: appTheme().colorScheme.lavender,
                                      ),
                                    ),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      color: appTheme().colorScheme.lavender,
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                                Text(
                                  widget.data.groupDescription ?? "",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w400,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  maxLines: 2,
                                ),
                                const Spacer(),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    SizedBox(
                                      height: 18.h,
                                      width: 18.w,
                                      child: Image.asset(AssetsRes.LOCATION),
                                    ),
                                    Text(
                                      widget.data.locationArea ?? "",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: appTheme().colorScheme.textGrey,
                                      ),
                                    ),
                                    SizedBox(width: 20.w),
                                    SizedBox(
                                      height: 18.h,
                                      width: 18.w,
                                      child: Image.asset(
                                        AssetsRes.COMMUNITY_BLACK,
                                      ),
                                    ),
                                    Text(
                                      "${widget.data.memberCount} Members",
                                      style: TextStyle(
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w500,
                                        color: appTheme().colorScheme.textGrey,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Positioned(
                      top: 610.h,
                      right: 20.w,
                      child: InkWell(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(30.r),
                            border: Border.all(
                              color: appTheme().colorScheme.lavender,
                            ),
                          ),
                          height: 40.h,
                          width: 80.w,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.edit,
                                color: Colors.black,
                                size: 20.sp,
                              ),
                              Text("Edit"),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Positioned(
                          top: 90.h,
                          child: MyNetworkImage.networkImage(
                            35.r,
                            widget.data.coverPhotoUrl ?? "",
                            BoxFit.cover,
                          ),
                        ),
                        Positioned(
                          top: 120.h,
                          left: 50.w,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: appTheme().colorScheme.lavender,
                              ),
                            ),
                            height: 30.r,
                            width: 30.r,
                            child: Icon(
                              Icons.edit,
                              color: Colors.black,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10.h),
              // CarouselSlider.builder(
              //     itemCount: 2, itemBuilder: itemBuilder, options: options)
              SizedBox(height: 10.h),
              TabBar(
                isScrollable: true,
                tabAlignment: TabAlignment.center,
                onTap: (newValue) {
                  _tabIndexNotifier.value = newValue;
                },
                dividerColor: Colors.transparent,
                indicator: BoxDecoration(color: Colors.transparent),
                tabs: [
                  tabIcons(AssetsRes.POST, "Post", 0),
                  tabIcons(AssetsRes.EVENT, "Event", 1),
                  tabIcons(AssetsRes.BISHI_GROUP, "Bishi group", 2),
                  tabIcons(AssetsRes.JOB, "Job", 3),
                  tabIcons(AssetsRes.POLL, "Poll", 4),
                ],
                controller: _tabController,
              ),
              SizedBox(height: 20.h),
              SizedBox(
                height: 400.h,
                child: TabBarView(
                  controller: _tabController,
                  physics: NeverScrollableScrollPhysics(),
                  children: [
                    tabIcons(AssetsRes.POST, "Post", 0),
                    tabIcons(AssetsRes.EVENT, "Event", 1),
                    tabIcons(AssetsRes.BISHI_GROUP, "Bishi group", 2),
                    tabIcons(AssetsRes.JOB, "Job", 3),
                    tabIcons(AssetsRes.POLL, "Poll", 4),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: ExpandableFab(
        distance: 40.h,
        pos: ExpandableFabPos.right,
        type: ExpandableFabType.up,
        childrenAnimation: ExpandableFabAnimation.rotate,
        openButtonBuilder: RotateFloatingActionButtonBuilder(
          shape: CircleBorder(),
          backgroundColor: appTheme().colorScheme.iceBlue,
          child: Image.asset(AssetsRes.ADD_POST, height: 30.r, width: 30.r),
        ),
        closeButtonBuilder: DefaultFloatingActionButtonBuilder(
          child: Icon(Icons.close, color: appTheme().colorScheme.lavender),
          foregroundColor: appTheme().colorScheme.lavender,
          backgroundColor: appTheme().colorScheme.iceBlue,
          shape: const CircleBorder(),
        ),
        children: [
          SizedBox.shrink(),
          fabItemBuilder("Request", AssetsRes.REQUEST, () {}),
          fabItemBuilder("Group", AssetsRes.BISHI_GROUP, () {}),
          fabItemBuilder("Event", AssetsRes.EVENT, () {
            Get.to(() => CreateEventScreen());
          }),
          fabItemBuilder("Post", AssetsRes.POST, () {}),
          fabItemBuilder("Poll", AssetsRes.POLL, () {}),
          fabItemBuilder("Job", AssetsRes.JOB, () {}),
        ],
      ),
    );
  }

  Widget tabIcons(String icon, String text, int index) {
    return ValueListenableBuilder<int>(
      valueListenable: _tabIndexNotifier,
      builder: (context, value, _) => AnimatedContainer(
        height: 42.h,
        // width: 120.w,
        alignment: Alignment.center,
        duration: const Duration(milliseconds: 750),
        curve: Curves.bounceInOut,
        decoration: (value == index)
            ? BoxDecoration(
                color: appTheme().colorScheme.iceBlue,
                borderRadius: BorderRadius.circular(30.r),
              )
            : BoxDecoration(
                color: Colors.white,
                border: Border.all(color: appTheme().colorScheme.iceBlue),
                borderRadius: BorderRadius.circular(30.r),
              ),
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 5.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: 21.r, width: 21.r, child: Image.asset(icon)),
            SizedBox(width: 10.w),
            Flexible(
              child: Text(
                text,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                  color: appTheme().colorScheme.lavender,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget fabItemBuilder(String name, String icon, Function()? onPress) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: appTheme().colorScheme.lavender),
          borderRadius: BorderRadius.circular(30.r),
        ),
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(name),
            SizedBox(width: 10.w),
            Image.asset(icon, height: 15.r, width: 15.r),
            SizedBox(width: 10.w),
            Icon(Icons.arrow_forward_ios, color: Colors.black, size: 15.sp),
          ],
        ),
      ),
    );
  }
}

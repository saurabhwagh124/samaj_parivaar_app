import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/res/assets_res.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/create_post_page.dart';
import 'package:samaj_parivaar_app/view/landing/events_page.dart';
import 'package:samaj_parivaar_app/view/landing/group_page.dart';
import 'package:samaj_parivaar_app/view/landing/home_page.dart';
import 'package:samaj_parivaar_app/view/landing/profile_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final pageController = PageController(initialPage: 0);
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: pageController,
        children: [
          HomePage(),
          GroupPage(),
          CreatePostPage(),
          EventsPage(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (newIndex) => changePage(newIndex),
        currentIndex: _currentIndex,
        showUnselectedLabels: true,
        showSelectedLabels: true,
        selectedLabelStyle: TextStyle(
          fontSize: 13.sp,
          fontWeight: FontWeight.w600,
          color: appTheme().colorScheme.lavender,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12.sp,
          fontWeight: FontWeight.w600,
          color: appTheme().colorScheme.lavender,
        ),
        items: [
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              radius: 20.r,
              backgroundColor: appTheme().colorScheme.iceBlue,
              child: Image.asset(AssetsRes.HOME, height: 20.r, width: 20.r),
            ),
            icon: Image.asset(AssetsRes.HOME, height: 20.r, width: 20.r),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              radius: 20.r,
              backgroundColor: appTheme().colorScheme.iceBlue,
              child: Image.asset(
                AssetsRes.COMMUNITY,
                height: 20.r,
                width: 20.r,
              ),
            ),
            icon: Image.asset(AssetsRes.COMMUNITY, height: 20.r, width: 20.r),
            label: "Groups",
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              radius: 20.r,
              backgroundColor: appTheme().colorScheme.iceBlue,
              child: Image.asset(AssetsRes.ADD_POST, height: 20.r, width: 20.r),
            ),
            icon: Image.asset(AssetsRes.ADD_POST, height: 20.r, width: 20.r),
            label: "Post",
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              radius: 20.r,
              backgroundColor: appTheme().colorScheme.iceBlue,
              child: Image.asset(AssetsRes.EVENTS, height: 20.r, width: 20.r),
            ),
            icon: Image.asset(AssetsRes.EVENTS, height: 20.r, width: 20.r),
            label: "Event",
          ),
          BottomNavigationBarItem(
            activeIcon: CircleAvatar(
              radius: 20.r,
              backgroundColor: appTheme().colorScheme.iceBlue,
              child: Image.asset(
                AssetsRes.PERSON_PROFILE,
                height: 20.r,
                width: 20.r,
              ),
            ),
            icon: Image.asset(
              AssetsRes.PERSON_PROFILE,
              height: 20.r,
              width: 20.r,
            ),
            label: "Profile",
          ),
        ],
      ),
    );
  }

  void changePage(int index) {
    setState(() {
      _currentIndex = index;
    });
    pageController.animateToPage(
      index,
      duration: Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }
}

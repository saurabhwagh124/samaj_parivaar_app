import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:samaj_parivaar_app/model/user.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';
import 'package:samaj_parivaar_app/widgets/my_network_image.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? user;

  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    final data = await LocalStorage.i.getUser("current_user");
    user = User.fromJson(jsonDecode(data));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            MyNetworkImage.networkImage(
              126.r,
              user?.profilePhotoUrl ?? "",
              BoxFit.contain,
            ),
            Positioned(
              bottom: 0,
              right: 0,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

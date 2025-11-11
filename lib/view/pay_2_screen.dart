import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_pay_upi/flutter_pay_upi_manager.dart';
import 'package:flutter_pay_upi/model/upi_app_model.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/service/auth_service.dart';
import 'package:samaj_parivaar_app/view/intro_page.dart';

class Pay2Screen extends StatefulWidget {
  const Pay2Screen({super.key});

  @override
  State<Pay2Screen> createState() => _Pay2ScreenState();
}

class _Pay2ScreenState extends State<Pay2Screen> {
  List<UpiApp> androidUpiList = [];

  @override
  void initState() {
    super.initState();
    getApps();
  }

  void getApps() async {
    androidUpiList.addAll(await FlutterPayUpiManager.getListOfAndroidUpiApps());
    if (androidUpiList.isNotEmpty) {
      for (UpiApp upiApp in androidUpiList) {
        log(upiApp.name ?? "NONE");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) =>
                  Image.memory(androidUpiList[index].icon!),
              itemCount: androidUpiList.length,
            ),
          ),
          Expanded(
            child: Center(
              child: TextButton(
                onPressed: () {
                  getApps();
                },
                child: Text("Get Apps"),
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              AuthService().logout();
              Get.to(() => IntroPage());
            },
            child: Text("Logout"),
          ),
        ],
      ),
    );
  }
}

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:samaj_parivaar_app/controller/auth_controller.dart';
import 'package:samaj_parivaar_app/controller/community_controller.dart';
import 'package:samaj_parivaar_app/utils/app_colors.dart';
import 'package:samaj_parivaar_app/view/splash_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(440, 956),
      child: GetMaterialApp(
        title: 'Parivaar',
        debugShowCheckedModeBanner: false,
        theme: appTheme(),
        initialBinding: BindingsBuilder.put(() async {
          Get.put(AuthController());
          Get.put(CommunityController());
        }),
        // home: const LoginPage(),
        home: const SplashScreen(),
      ),
    );
  }
}

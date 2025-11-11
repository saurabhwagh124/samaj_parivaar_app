import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:samaj_parivaar_app/model/user.dart';
import 'package:samaj_parivaar_app/service/auth_service.dart';
import 'package:samaj_parivaar_app/utils/local_storage.dart';

class AuthController extends GetxController {
  final service = AuthService();
  RxBool isLoading = false.obs;
  Rx<User?> currentUser = Rx<User?>(null);

  Future<bool> login(String email, String password) async {
    isLoading.value = true;
    try {
      currentUser.value = await service.login(email, password);
      await LocalStorage.i.setLoggedIn(true);
      return true;
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }

  Future<bool> register(String fullName, String email, String password) async {
    isLoading.value = true;
    try {
      await service.register(fullName, email, password);
      return true;
    } catch (e) {
      log(e.toString());
      Get.snackbar(
        "Error",
        e.toString(),
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

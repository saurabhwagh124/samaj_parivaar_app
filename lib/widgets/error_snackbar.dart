import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyErrorSnackBar {
  static SnackbarController showErrorSnackBar(String title, String message) {
    return Get.snackbar(
      "Error",
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
    );
  }
}

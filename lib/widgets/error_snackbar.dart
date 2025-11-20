import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MySnackBar {
  static SnackbarController showErrorSnackBar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.red,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  static SnackbarController showSuccessSnackBar(String title, String message) {
    return Get.snackbar(
      title,
      message,
      colorText: Colors.white,
      backgroundColor: Colors.green,
      snackStyle: SnackStyle.FLOATING,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

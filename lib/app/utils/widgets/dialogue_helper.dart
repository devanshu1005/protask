import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DialogHelper {
  static void showError(String message, {String title = 'Error', Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.red.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
    );
  }

  static void showSuccess(String message, {String title = 'Success', Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.green.shade600,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
    );
  }

  static void showInfo(String message, {String title = 'Info', Color? backgroundColor}) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: backgroundColor ?? Colors.blueGrey,
      colorText: Colors.white,
      duration: const Duration(seconds: 3),
      margin: const EdgeInsets.all(12),
    );
  }
}


import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showCustomSnackBar(String message, {bool isError = true}) {
  Get.showSnackbar(GetSnackBar(
    message: message,
    backgroundColor: isError ? Colors.red : Colors.green,
    borderRadius: 10,
    margin: const EdgeInsets.only(bottom: 70, left: 20, right: 20),
    onTap: (snack) {
      Get.back();
    },
  ));
}

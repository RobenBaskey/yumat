import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/utils/app_colors.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      this.onSuffixTap,
      this.isObscure = false,
      this.isPassword = false,
      this.isVisible = false});
  final TextEditingController controller;
  final String hintText;
  final bool isObscure;
  final bool isPassword;
  final bool isVisible;
  final VoidCallback? onSuffixTap;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return TextFormField(
      obscureText: isObscure,
      controller: controller,
      decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          suffixIcon: isPassword
              ? InkWell(
                  onTap: onSuffixTap,
                  child: isVisible
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                )
              : const SizedBox(),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
              borderSide: BorderSide(color: AppColor.logoColor)),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
              borderSide: BorderSide(color: AppColor.white)),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(width * 0.03),
              borderSide: BorderSide(color: AppColor.white)),
          fillColor: AppColor.white),
    );
  }
}

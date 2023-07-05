import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/helper/routes.dart';
import 'package:yuma_test/utils/app_colors.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _route();
    super.initState();
  }

  void _route() {
    Future.delayed(const Duration(seconds: 2), () {
      if (Get.find<AuthController>().isLoggedIn()) {
        Navigator.pushReplacementNamed(context, RouteClass.getHomePage());
      } else {
        Navigator.pushReplacementNamed(context, RouteClass.getLoginPage());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "YUMA",
              style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColor.logoColor,
                  letterSpacing: 2),
            ),
            SizedBox(
              width: width,
            ),
            Text(
              "TECHNOLOGY",
              style: TextStyle(
                  fontSize: width * 0.06,
                  fontWeight: FontWeight.bold,
                  color: AppColor.logoColor,
                  letterSpacing: 2),
            ),
          ]),
    );
  }
}

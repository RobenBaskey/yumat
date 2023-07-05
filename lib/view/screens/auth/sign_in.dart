import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/helper/routes.dart';
import 'package:yuma_test/utils/app_colors.dart';
import 'package:yuma_test/view/base/custom_snackbar.dart';
import 'package:yuma_test/view/base/custom_textfield.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  @override
  void initState() {
    Get.find<AuthController>().createOpenBox();
    super.initState();
  }

  final GlobalKey<FormState> _formKeyLogin = GlobalKey<FormState>();

  void login(BuildContext context) {
    if (_formKeyLogin.currentState!.validate()) {
      Get.find<AuthController>().signIn(route, context);
    }
  }

  route(bool isRoute, BuildContext context) {
    if (isRoute) {
      Navigator.pushNamedAndRemoveUntil(
          context, RouteClass.getHomePage(), (route) => false);
    } else {
      showCustomSnackBar("Request failed. Please try again!");
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<AuthController>(builder: (authController) {
      return Scaffold(
        backgroundColor: AppColor.authBgColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.04),
            child: Column(children: <Widget>[
              SizedBox(
                height: height * 0.14,
              ),
              Text(
                "YUMA",
                style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.w700,
                    color: AppColor.logoColor,
                    letterSpacing: 4),
              ),
              Text(
                "TECHNOLOGY",
                style: TextStyle(
                    fontSize: width * 0.08,
                    fontWeight: FontWeight.w700,
                    color: AppColor.logoColor,
                    letterSpacing: 4),
              ),
              SizedBox(
                height: height * 0.15,
              ),
              Form(
                  key: _formKeyLogin,
                  child: Column(
                    children: <Widget>[
                      CustomTextField(
                          controller: authController.emailController,
                          hintText: "Email"),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      CustomTextField(
                        controller: authController.passwordController,
                        hintText: "Password",
                        isObscure: !authController.isPasswordVisible,
                        isPassword: true,
                        onSuffixTap: () {
                          authController.changePasswordVisiblity();
                        },
                        isVisible: authController.isPasswordVisible,
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Checkbox(
                            value: authController.isRememberCheck,
                            onChanged: (value) {
                              authController.changeRememberData();
                            },
                            checkColor: AppColor.white,
                            activeColor: AppColor.logoColor,
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyle(
                              fontSize: width * 0.03,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: height * 0.03,
                      ),
                      authController.isSingInLoading
                          ? const CircularProgressIndicator()
                          : GestureDetector(
                              onTap: () {
                                login(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(width * 0.035),
                                width: width,
                                decoration: BoxDecoration(
                                    color: AppColor.logoColor,
                                    borderRadius:
                                        BorderRadius.circular(width * 0.03)),
                                child: Center(
                                  child: Text(
                                    "Sing in",
                                    style: TextStyle(
                                        fontSize: width * 0.045,
                                        color: Colors.white,
                                        letterSpacing: 2,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                              ),
                            )
                    ],
                  ))
            ]),
          ),
        ),
      );
    });
  }
}

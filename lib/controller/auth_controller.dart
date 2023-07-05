// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:yuma_test/data/api/dio_client.dart';
import 'package:yuma_test/data/model/Response/api_response.dart';
import 'package:yuma_test/data/model/sign_in_model.dart';
import 'package:yuma_test/data/repository/auth_repository.dart';

class AuthController extends GetxController {
  final AuthRepo authRepo;
  final DioClient dioClient;
  AuthController({required this.authRepo, required this.dioClient});

  bool _isSignInLoading = false;
  bool _isPasswordVisible = false;
  bool _isRememberChecked = false;
  final Key _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool get isSingInLoading => _isSignInLoading;
  bool get isPasswordVisible => _isPasswordVisible;
  bool get isRememberCheck => _isRememberChecked;
  Key get formKey => _formKey;
  TextEditingController get emailController => _emailController;
  TextEditingController get passwordController => _passwordController;

  late Box _box1;

  void createOpenBox() async {
    _box1 = await Hive.openBox('loginData');
    getData();
  }

  void getData() async {
    if (_box1.get('email') != null) {
      _emailController.text = _box1.get('email');
    }
    if (_box1.get('password') != null) {
      _passwordController.text = _box1.get('password');
    }
    update();
  }

  changePasswordVisiblity() {
    _isPasswordVisible = !_isPasswordVisible;
    update();
  }

  changeRememberData() {
    _isRememberChecked = !_isRememberChecked;
    update();
  }

  bool isLoggedIn() {
    return authRepo.isLoggedIn();
  }

  Future<bool> logOut() async {
    return await authRepo.handleLogout();
  }

  Future signIn(Function callback, BuildContext context) async {
    _isSignInLoading = true;
    update();
    SignInPostModel signInPostModel = SignInPostModel(
        email: _emailController.text, password: _passwordController.text);
    ApiResponse apiResponse = await authRepo.signIn(signInPostModel);

    _isSignInLoading = false;
    if (apiResponse.response != null &&
        apiResponse.response!.statusCode == 200) {
      var data = apiResponse.response!.data;
      authRepo.saveUserToken(data['data']['_token']);
      if (_isRememberChecked) {
        _box1.put('email', emailController.text);
        _box1.put('password', passwordController.text);
      } else {
        _box1.clear();
      }
      callback(true, context);
      update();
    } else {
      callback(false, context);
      update();
    }
  }
}

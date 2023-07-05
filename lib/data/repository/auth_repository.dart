import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuma_test/data/api/dio_client.dart';
import 'package:yuma_test/data/exception/api_error_handler.dart';
import 'package:yuma_test/data/model/Response/api_response.dart';
import 'package:yuma_test/data/model/sign_in_model.dart';
import 'package:yuma_test/utils/app_constants.dart';

class AuthRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.dioClient, required this.sharedPreferences});

  signIn(SignInPostModel model) async {
    try {
      Response response =
          await dioClient.post(AppConstants.loginUrl, data: model.toJson());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }

  //for check login
  bool isLoggedIn() {
    return sharedPreferences.getBool(AppConstants.loggedIn) ?? false;
  }

  //for log out
  Future<bool> handleLogout() async {
    return await sharedPreferences.clear();
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    dioClient.token = token;
    dioClient.dio.options.headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };

    try {
      await sharedPreferences.setString(AppConstants.token, token);
      await sharedPreferences.setBool(AppConstants.loggedIn, true);
    } catch (e) {
      rethrow;
    }
  }
}

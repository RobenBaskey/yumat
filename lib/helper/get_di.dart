import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/controller/home_controller.dart';
import 'package:yuma_test/data/api/dio_client.dart';
import 'package:yuma_test/data/repository/auth_repository.dart';
import 'package:yuma_test/data/repository/home_repo.dart';
import 'package:yuma_test/utils/app_constants.dart';

Future<void> init() async {
  // Core
  final sharedPreferences = await SharedPreferences.getInstance();
  Get.lazyPut(() => sharedPreferences);
  Get.lazyPut(() => DioClient(
      baseUrl: AppConstants.baseUrl,
      dioC: Dio(),
      sharedPreferences: sharedPreferences));

  // Repository
  Get.lazyPut(
      () => AuthRepo(dioClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => HomeRepo(dioClient: Get.find()));

  // Controller
  Get.lazyPut(
      () => AuthController(authRepo: Get.find(), dioClient: Get.find()));
  Get.lazyPut(
      () => HomeController(homeRepo: Get.find(), dioClient: Get.find()));
}

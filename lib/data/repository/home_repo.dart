import 'package:dio/dio.dart';
import 'package:yuma_test/data/api/dio_client.dart';
import 'package:yuma_test/data/exception/api_error_handler.dart';
import 'package:yuma_test/data/model/Response/api_response.dart';
import 'package:yuma_test/utils/app_constants.dart';

class HomeRepo {
  final DioClient dioClient;

  HomeRepo({required this.dioClient});

  Future<ApiResponse> getProviderList() async {
    try {
      Response response = await dioClient.get(AppConstants.providerUrl);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e));
    }
  }
}

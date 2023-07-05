import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:yuma_test/data/api/dio_client.dart';
import 'package:yuma_test/data/model/Response/api_response.dart';
import 'package:yuma_test/data/model/provider_list_model.dart';
import 'package:yuma_test/data/repository/home_repo.dart';

class HomeController extends GetxController {
  final HomeRepo homeRepo;
  final DioClient dioClient;
  HomeController({required this.homeRepo, required this.dioClient});

  bool _isProviderListLoading = false;
  List<Datum> _providerList = [];

  bool get isProviderListLoading => _isProviderListLoading;
  List<Datum> get providerList => _providerList;

  getProviderList() async {
    _isProviderListLoading = true;
    update();
    try {
      ApiResponse apiResponse = await homeRepo.getProviderList();
      _providerList.clear();
      ProviderListModel model =
          ProviderListModel.fromJson(apiResponse.response!.data);
      for (var element in model.data) {
        if (element.highlight == 1) {
          _providerList.add(element);
        }
      }
    } on Exception catch (e) {
      debugPrint(e.toString());
      _isProviderListLoading = false;
      update();
    }
    _isProviderListLoading = false;
    update();
  }
}

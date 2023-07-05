import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/controller/home_controller.dart';
import 'package:yuma_test/helper/routes.dart';
import 'package:yuma_test/utils/app_colors.dart';
import 'package:yuma_test/utils/app_constants.dart';
import 'package:yuma_test/utils/app_images.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final homeController = Get.find<HomeController>();
  final authControler = Get.find<AuthController>();

  @override
  void initState() {
    homeController.getProviderList();
    super.initState();
  }

  logout(BuildContext context) async {
    var result = await authControler.logOut();
    if (result) {
      // ignore: use_build_context_synchronously
      Navigator.pushNamedAndRemoveUntil(
          context, RouteClass.getLoginPage(), (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return GetBuilder<HomeController>(builder: (homeController) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "Yuma Technology",
            style: TextStyle(
                fontSize: width * 0.045,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
                color: AppColor.logoColor),
          ),
          centerTitle: false,
          actions: [
            IconButton(
                onPressed: () {
                  logout(context);
                },
                icon: const Icon(Icons.logout))
          ],
        ),
        body: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            SizedBox(
              height: height * 0.03,
            ),
            SizedBox(
              height: height * 0.3,
              child: homeController.isProviderListLoading
                  ? ListView.builder(
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: EdgeInsets.only(left: width * 0.03),
                          child: Shimmer.fromColors(
                            baseColor: Colors.grey.withOpacity(0.1),
                            highlightColor: Colors.grey.withOpacity(0.15),
                            child: Container(
                              width: width * 0.5,
                              height: height * 0.25,
                              decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius:
                                      BorderRadius.circular(width * 0.02)),
                            ),
                          ),
                        );
                      })
                  : ListView.builder(
                      itemCount: homeController.providerList.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var model = homeController.providerList[index];
                        return Container(
                          width: width * 0.75,
                          margin:
                              EdgeInsets.symmetric(horizontal: width * 0.03),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.grey.withOpacity(0.3)),
                              borderRadius:
                                  BorderRadius.circular(width * 0.03)),
                          child: Column(children: <Widget>[
                            ClipRRect(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(width * 0.03),
                                  topLeft: Radius.circular(width * 0.03)),
                              child: FadeInImage.assetNetwork(
                                placeholder: AppImages.placeHolder,
                                imageErrorBuilder:
                                    (context, exception, stackTrace) {
                                  return Image.asset(
                                    AppImages.notFound,
                                    fit: BoxFit.cover,
                                  );
                                },
                                fit: BoxFit.cover,
                                width: width * 0.75,
                                height: height * 0.18,
                                image: AppConstants.baseUrl +
                                    model.backgroundImagePath,
                              ),
                            ),
                            Expanded(
                                child: Padding(
                              padding: EdgeInsets.all(width * 0.02),
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: FadeInImage.assetNetwork(
                                      placeholder: AppImages.placeHolder,
                                      imageErrorBuilder:
                                          (context, exception, stackTrace) {
                                        return Image.asset(
                                          AppImages.notFound,
                                          fit: BoxFit.cover,
                                        );
                                      },
                                      fit: BoxFit.cover,
                                      height: height * 0.07,
                                      width: height * 0.07,
                                      image: AppConstants.baseUrl +
                                          model.imagePath,
                                    ),
                                  ),
                                  SizedBox(
                                    width: width * 0.03,
                                  ),
                                  Expanded(
                                      flex: 4,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Text(
                                            model.businessName,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.035),
                                          ),
                                          Text(
                                            "${model.cashback.percentage}% Cashback",
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                color: Colors.red,
                                                fontSize: width * 0.035),
                                          ),
                                          Text(
                                            model.note,
                                            maxLines: 1,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: width * 0.035),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                            ))
                          ]),
                        );
                      }),
            ),
          ],
        )),
      );
    });
  }
}

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yuma_test/controller/home_controller.dart';
import 'package:yuma_test/utils/app_colors.dart';
import 'package:yuma_test/utils/app_constants.dart';
import 'package:yuma_test/utils/app_images.dart';

class VerticalItems extends StatelessWidget {
  const VerticalItems({super.key, required this.homeController});
  final HomeController homeController;

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.03),
      child: homeController.isProviderListLoading
          ? ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: height * 0.02),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey.withOpacity(0.1),
                    highlightColor: Colors.grey.withOpacity(0.15),
                    child: Container(
                      height: height * 0.18,
                      decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(width * 0.02)),
                    ),
                  ),
                );
              })
          : homeController.providerList.isEmpty
              ? const SizedBox()
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: homeController.providerList.length,
                  itemBuilder: (context, index) {
                    var model = homeController.providerList[index];
                    return Container(
                      margin: EdgeInsets.only(bottom: width * 0.03),
                      padding: EdgeInsets.all(width * 0.03),
                      decoration: BoxDecoration(
                          border:
                              Border.all(color: Colors.grey.withOpacity(0.3)),
                          borderRadius: BorderRadius.circular(width * 0.03)),
                      child: Row(children: <Widget>[
                        FadeInImage.assetNetwork(
                          placeholder: AppImages.placeHolder,
                          imageErrorBuilder: (context, exception, stackTrace) {
                            return Image.asset(
                              AppImages.notFound,
                              fit: BoxFit.cover,
                            );
                          },
                          fit: BoxFit.cover,
                          width: width * 0.2,
                          height: width * 0.2,
                          image: AppConstants.baseUrl + model.imagePath,
                        ),
                        SizedBox(
                          width: width * 0.04,
                        ),
                        Expanded(
                            child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              model.businessName,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: width * 0.035),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              "${model.cashback.percentage}% Cashback",
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w800,
                                  color: AppColor.red,
                                  fontSize: width * 0.035),
                            ),
                            SizedBox(
                              height: height * 0.01,
                            ),
                            Text(
                              model.note,
                              maxLines: 1,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: AppColor.orange,
                                  fontSize: width * 0.035),
                            )
                          ],
                        ))
                      ]),
                    );
                  }),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:yuma_test/controller/auth_controller.dart';
import 'package:yuma_test/controller/home_controller.dart';
import 'package:yuma_test/helper/routes.dart';
import 'package:yuma_test/utils/app_colors.dart';
import 'package:yuma_test/utils/app_constants.dart';
import 'package:yuma_test/utils/app_images.dart';
import 'package:yuma_test/view/screens/home/component/horizontal_items.dart';
import 'package:yuma_test/view/screens/home/component/vertical_items.dart';

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
            HorizontalItems(
              homeController: homeController,
            ),
            SizedBox(
              height: height * 0.02,
            ),
            VerticalItems(
              homeController: homeController,
            )
          ],
        )),
      );
    });
  }
}

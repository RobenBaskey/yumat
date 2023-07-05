import 'package:flutter/material.dart';
import 'package:yuma_test/view/screens/auth/sign_in.dart';
import 'package:yuma_test/view/screens/home/home_page.dart';
import 'package:yuma_test/view/screens/splash/splash.dart';

class RouteClass {
  static const String _splash = '/splash';
  static const String _login = '/login';
  static const String _home = '/home';

  static String getLoginPage() => _login;
  static String getHomePage() => _home;
  static String getSplashPage() => _splash;

  static var routes = <String, WidgetBuilder>{
    _splash: (context) => const SplashScreen(),
    _login: (context) => SignInScreen(),
    _home: (context) => const HomePage()
  };
}

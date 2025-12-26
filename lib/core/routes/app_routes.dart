import 'package:ecomm_422/features/on_boarding/presentation/ui/sign_up/sign_up_page.dart';
import 'package:ecomm_422/features/on_boarding/presentation/ui/splash/splash_page.dart';
import 'package:flutter/cupertino.dart';

import '../../features/on_boarding/presentation/ui/login/login_page.dart';

class AppRoutes{

  static const String splash_page = "/";
  static const String login_page = "/login";
  static const String sign_up_page = "/signUp";
  static const String dashboard_page = "/dashBoard";


  static Map<String, WidgetBuilder> mRoutes = {
    splash_page: (context) => SplashPage(),
    login_page: (context) => LoginPage(),
    sign_up_page: (context) => SignupPage(),
    /*dashboard_page: (context) => const DashBoardPage(),*/
  };
}
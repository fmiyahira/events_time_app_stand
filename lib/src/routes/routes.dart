import 'package:events_time_app_stand/src/features/auth/presentation/pages/login_page.dart';
import 'package:events_time_app_stand/src/features/auth/presentation/pages/splash_page.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_app_stand/src/features/home_cashier/presentation/home_cashier_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String get initialRoute => SplashPage.routeName;

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        LoginPage.routeName: (BuildContext context) => const LoginPage(),
        SplashPage.routeName: (BuildContext context) => const SplashPage(),
        SelectConfigurationPage.routeName: (BuildContext context) =>
            const SelectConfigurationPage(),
        HomeCashierPage.routeName: (BuildContext context) =>
            const HomeCashierPage(),
      };
}

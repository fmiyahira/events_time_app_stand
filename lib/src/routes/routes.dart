import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_app_stand/src/features/home_cashier/presentation/home_cashier_page.dart';
import 'package:flutter/material.dart';

class AppRoutes {
  String get initialRoute => 'auth';

  Map<String, WidgetBuilder> get routes => <String, WidgetBuilder>{
        SelectConfigurationPage.routeName: (BuildContext context) =>
            const SelectConfigurationPage(),
        HomeCashierPage.routeName: (BuildContext context) =>
            const HomeCashierPage(),
      };
}

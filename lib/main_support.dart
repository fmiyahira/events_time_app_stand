import 'package:events_time_app_stand/flavors.dart';
import 'package:events_time_app_stand/src/routes/routes.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';
import 'package:flutter/material.dart';

import 'src/features/configuration/presentation/pages/select_configuration_page.dart';

List<ISubApp> subAppsRegistered = <ISubApp>[
  MicroappAuth(
    microappAuthConfig: MicroappAuthConfig(
      authGoalEnum: AuthGoalEnum.user,
      destinationAfterLogin: SelectConfigurationPage.routeName,
    ),
  ),
];

Map<String, WidgetBuilder> allRoutes = <String, WidgetBuilder>{
  ...AppRoutes().routes,
};

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  final IRequesting requesting = Requesting(baseUrl: F.baseUrl);
  final IInjector injector = AppInjector();

  for (final ISubApp subApp in subAppsRegistered) {
    final SubAppRegistration registration = subApp.register();

    allRoutes.addAll(registration.routes);

    await subApp.initialize(
      requesting: requesting,
      injector: injector,
    );
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: <Flavor>[
        Flavor.hom,
        Flavor.dev,
      ].contains(F.appFlavor),
      title: F.title,
      initialRoute: AppRoutes().initialRoute,
      routes: allRoutes,
    );
  }
}

import 'package:events_time_app_stand/flavors.dart';
import 'package:events_time_app_stand/src/routes/routes.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';
import 'package:flutter/material.dart';

import 'src/features/configuration/core/register_dependencies_configuration.dart';
import 'src/features/configuration/domain/models/related_event_model.dart';
import 'src/features/configuration/domain/models/related_stand_model.dart';
import 'src/features/configuration/presentation/pages/select_configuration_page.dart';

class AppStand {
  static final AppStand _appStand = AppStand._internal();

  factory AppStand() {
    return _appStand;
  }

  AppStand._internal();

  Map<String, WidgetBuilder> allRoutes = <String, WidgetBuilder>{
    ...AppRoutes().routes,
  };

  List<ISubApp> subAppsRegistered = <ISubApp>[
    MicroappAuth(
      microappAuthConfig: MicroappAuthConfig(
        authGoalEnum: AuthGoalEnum.user,
        destinationAfterLogin: SelectConfigurationPage.routeName,
      ),
    ),
  ];

  late IInjector injector;
  late ILocalStorage localStorage;
  late IRequesting requesting;

  RelatedEventModel? eventSelected;
  RelatedStandModel? standSelected;

  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();

    injector = AppInjector();
    localStorage = LocalStorageSembastImpl(
      await SembastImpl().openDatabase(),
    );
    requesting = Requesting(
      baseUrl: F.baseUrl,
      localStorage: localStorage,
    );

    for (final ISubApp subApp in subAppsRegistered) {
      final SubAppRegistration registration = subApp.register();

      if (registration.routes != null) allRoutes.addAll(registration.routes!);

      await subApp.initialize(
        requesting: requesting,
        injector: injector,
        localStorage: localStorage,
      );
    }

    // Register dependencies
    final List<IRegisterDependencies> listInternalDependencies =
        <IRegisterDependencies>[
      RegisterDependenciesConfiguration(),
    ];

    for (final IRegisterDependencies internalDependency
        in listInternalDependencies) {
      await internalDependency.register();
    }

    runApp(const MyApp());
  }
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
      routes: AppStand().allRoutes,
    );
  }
}

import 'package:events_time_app_stand/flavors.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer.dart';
import 'package:events_time_app_stand/src/core/plugins/register_dependencies_plugins.dart';
import 'package:events_time_app_stand/src/features/menu/core/register_dependencies_menu.dart';
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
        callbackAfterLogin: (UserModel userModel) {
          AppStand().userLogged = userModel;
        },
        callbackAfterLogout: () {
          AppStand().eventSelected = null;
          AppStand().standSelected = null;
          AppStand().userLogged = null;
        },
      ),
    ),
  ];

  late IInjector injector;
  late ILocalStorage localStorage;
  late IRequesting requesting;

  RelatedEventModel? eventSelected;
  RelatedStandModel? standSelected;
  UserModel? userLogged;

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
      RegisterDependenciesPlugins(),
      RegisterDependenciesMenu(),
      RegisterDependenciesConfiguration(),
    ];

    for (final IRegisterDependencies internalDependency
        in listInternalDependencies) {
      await internalDependency.register();
    }

    runApp(const MyApp());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final IBluetoothPrinter bluetoothPrinter = AppStand().injector.get();

    switch (state) {
      case AppLifecycleState.resumed:
        if (bluetoothPrinter.lastPrinterConnected.isNotEmpty)
          bluetoothPrinter.connectDevice(bluetoothPrinter.lastPrinterConnected);
        break;
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
      case AppLifecycleState.inactive:
        if (bluetoothPrinter.isConnected) bluetoothPrinter.disconnectDevice();
        break;
    }
  }

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

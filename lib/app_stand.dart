import 'package:events_time_app_stand/flavors.dart';
import 'package:events_time_app_stand/src/core/plugins/bluetooth_printer/bluetooth_printer.dart';
import 'package:events_time_app_stand/src/core/plugins/register_dependencies_plugins.dart';
import 'package:events_time_app_stand/src/features/home_cashier/presentation/home_cashier_page.dart';
import 'package:events_time_app_stand/src/features/menu/core/register_dependencies_menu.dart';
import 'package:events_time_app_stand/src/routes/routes.dart';
import 'package:events_time_microapp_auth/events_time_microapp_auth.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';
import 'package:events_time_microapp_hub/microapp/hub_states.dart';
import 'package:events_time_microapp_hub/microapp/microapp_hub.dart';
import 'package:flutter/material.dart';

import 'src/features/configuration/core/register_dependencies_configuration.dart';
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

  final GlobalKey<NavigatorState> mainNavigatorKey =
      GlobalKey<NavigatorState>();

  List<ISubApp> subAppsRegistered = <ISubApp>[
    MicroappAuth(
      microappAuthConfig: MicroappAuthConfig(
        authGoalEnum: AuthGoalEnum.client,
        destinationAfterLogin: SelectConfigurationPage.routeName,
        destinationHome: HomeCashierPage.routeName,
      ),
    ),
  ];

  late IInjector injector;
  late ILocalStorage localStorage;
  late IRequesting requesting;
  late MicroappHub hub;

  UserModel? userLogged;
  LoggedEventModel? loggedEvent;
  LoggedStandModel? loggedStand;

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
    hub = MicroappHub();

    final Map<String, ValueNotifier<dynamic>> messengers =
        <String, ValueNotifier<dynamic>>{
      'hub': hub,
    };

    for (final ISubApp subApp in subAppsRegistered) {
      final SubAppRegistration registration = subApp.register();

      if (registration.routes != null) allRoutes.addAll(registration.routes!);

      await subApp.initialize(
        requesting: requesting,
        injector: injector,
        localStorage: localStorage,
        mainNavigatorKey: mainNavigatorKey,
        messengers: messengers,
      );
    }

    // Register dependencies
    final List<IRegisterDependencies> listInternalDependencies =
        <IRegisterDependencies>[
      RegisterDependenciesPlugins(),
      RegisterDependenciesConfiguration(),
      RegisterDependenciesMenu(),
    ];

    for (final IRegisterDependencies internalDependency
        in listInternalDependencies) {
      await internalDependency.register();
    }

    registerMessengersListeners();

    runApp(const MyApp());
  }

  void registerMessengersListeners() {
    MicroappAuth.hub.addListener(() {
      if (hub.value is ResponseUserLoggedHubState) {
        userLogged =
            (hub.value as ResponseUserLoggedHubState).payload as UserModel?;
        return;
      }

      if (hub.value is ResponseEventSelectedHubState) {
        loggedEvent = (hub.value as ResponseEventSelectedHubState).payload
            as LoggedEventModel?;
        return;
      }

      if (hub.value is ResponseStandSelectedHubState) {
        loggedStand = (hub.value as ResponseStandSelectedHubState).payload
            as LoggedStandModel?;
        return;
      }
    });
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
      navigatorKey: AppStand().mainNavigatorKey,
    );
  }
}

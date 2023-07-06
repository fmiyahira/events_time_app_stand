import 'package:events_time_app_stand/flavors.dart';
import 'package:events_time_app_stand/src/routes/routes.dart';
import 'package:flutter/material.dart';

void main() => initialize();

void buildFromFlavor() => main();

Future<void> initialize() async {
  WidgetsFlutterBinding.ensureInitialized();

  // await RegisterDependencies().register();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner:
          <Flavor>[Flavor.hom, Flavor.dev].contains(F.appFlavor),
      title: F.title,
      initialRoute: AppRoutes().initialRoute,
      routes: AppRoutes().routes,
    );
  }
}

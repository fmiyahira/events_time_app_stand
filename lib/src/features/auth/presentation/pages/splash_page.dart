import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/auth/presentation/controllers/splash_states.dart';
import 'package:events_time_app_stand/src/features/auth/presentation/controllers/splash_store.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/pages/select_configuration_page.dart';
import 'package:events_time_app_stand/src/features/home_cashier/presentation/home_cashier_page.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  SplashStore splashStore = AppStand().injector.get();
  late Function() splashStoreListener;

  @override
  void initState() {
    super.initState();

    splashStoreListener = _getSplashStoreListener;
    splashStore.addListener(splashStoreListener);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      splashStore.verifyIsLogged();
    });
  }

  @override
  void dispose() {
    splashStore.removeListener(splashStoreListener);
    super.dispose();
  }

  Function() get _getSplashStoreListener => () {
        if (splashStore.value is LoggedWithEventAndStandState) {
          Navigator.of(context).pushReplacementNamed(
            HomeCashierPage.routeName,
          );
          return;
        }

        if (splashStore.value is LoggedWithoutEventAndStandState) {
          Navigator.of(context).pushReplacementNamed(
            SelectConfigurationPage.routeName,
          );
          return;
        }

        if (splashStore.value is NotLoggedState) {
          Navigator.of(context).pushReplacementNamed(
            'auth',
          );
          return;
        }
      };

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

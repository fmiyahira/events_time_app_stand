import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  static String routeName = '/splash';

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  // SplashController splashController = AppInjector.I.get();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  Future<void> _initialize() async {
    // final bool hasLoggedUser = await splashController.hasLoggedUser();
    if (!mounted) return;

    // if (!hasLoggedUser) {
    await Future<void>.delayed(const Duration(seconds: 2));

    Navigator.of(context).pushReplacementNamed(
      '/auth/login',
    );
    // return;
    // }

    // Navigator.of(context).pushReplacementNamed(VisitsPage.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

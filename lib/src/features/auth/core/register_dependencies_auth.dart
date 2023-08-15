import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/auth/presentation/controllers/splash_store.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class RegisterDependenciesAuth implements IRegisterDependencies {
  @override
  Future<void> register() async {
    // Stores
    AppStand().injector.registerFactory<SplashStore>(
          () => SplashStore(
            requesting: AppStand().requesting,
            getSelectedEventUsecase: AppStand().injector.get(),
            getSelectedStandUsecase: AppStand().injector.get(),
            getUserLoggedInfoUsecase: AppStand().injector.get(),
          ),
        );
  }
}

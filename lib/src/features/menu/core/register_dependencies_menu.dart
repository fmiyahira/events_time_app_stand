import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/menu/presentation/controllers/menu_store.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class RegisterDependenciesMenu implements IRegisterDependencies {
  @override
  Future<void> register() async {
    // Stores
    AppStand().injector.registerFactory<MenuStore>(
          () => MenuStore(),
        );
  }
}

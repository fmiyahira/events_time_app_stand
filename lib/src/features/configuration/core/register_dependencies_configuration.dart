import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/configuration/data/implementations/local/selected_event_and_stand_datasource_local_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/data/implementations/remote/related_events_and_stands_datasource_remote_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/data/interfaces/local/selected_event_and_stand_datasource_local.dart';
import 'package:events_time_app_stand/src/features/configuration/data/interfaces/remote/related_events_and_stands_datasource_remote.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/get_related_events_and_stands_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/related_events_and_stands_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_related_events_and_stands_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/infra/implementations/related_events_and_stands_repository_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/presentation/controllers/select_configuration_store.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class RegisterDependenciesConfiguration implements IRegisterDependencies {
  @override
  Future<void> register() async {
    // Datasources
    AppStand()
        .injector
        .registerFactory<IRelatedEventsAndStandsDatasourceRemote>(() =>
            RelatedEventsAndStandsDatasourceRemoteImpl(AppStand().requesting));
    AppStand().injector.registerFactory<ISelectedEventAndStandDatasourceLocal>(
        () =>
            SelectedEventAndStandDatasourceLocalImpl(AppStand().localStorage));

    // Repositories
    AppStand().injector.registerFactory<IRelatedEventsAndStandsRepository>(
          () => RelatedEventsAndStandsRepositoryImpl(AppStand().injector.get()),
        );

    // Usecases
    AppStand().injector.registerFactory<IGetRelatedEventsAndStandsUsecase>(
          () => GetRelatedEventsAndStandsUsecaseImpl(AppStand().injector.get()),
        );

    // Stores
    AppStand().injector.registerFactory<SelectConfigurationStore>(
          () => SelectConfigurationStore(
            getRelatedEventsAndStandsUsecase: AppStand().injector.get(),
          ),
        );
  }
}

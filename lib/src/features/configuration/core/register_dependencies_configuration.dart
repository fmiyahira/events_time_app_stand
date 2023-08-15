import 'package:events_time_app_stand/app_stand.dart';
import 'package:events_time_app_stand/src/features/configuration/data/implementations/local/selected_event_and_stand_datasource_local_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/data/implementations/remote/related_events_and_stands_datasource_remote_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/data/interfaces/local/selected_event_and_stand_datasource_local.dart';
import 'package:events_time_app_stand/src/features/configuration/data/interfaces/remote/related_events_and_stands_datasource_remote.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/delete_selected_event_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/delete_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/get_related_events_and_stands_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/get_selected_event_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/get_selected_stand_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/set_selected_event_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/implementations/usecases/set_selected_stand_usecase_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/related_events_and_stands_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_related_events_and_stands_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/set_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/set_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/infra/implementations/related_events_and_stands_repository_impl.dart';
import 'package:events_time_app_stand/src/features/configuration/infra/implementations/selected_event_and_stand_repository_impl.dart';
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
    AppStand().injector.registerFactory<ISelectedEventAndStandRepository>(
          () => SelectedEventAndStandRepositoryImpl(AppStand().injector.get()),
        );

    // Usecases
    AppStand().injector.registerFactory<IGetRelatedEventsAndStandsUsecase>(
          () => GetRelatedEventsAndStandsUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<ISetSelectedEventUsecase>(
          () => SetSelectedEventUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<ISetSelectedStandUsecase>(
          () => SetSelectedStandUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<IGetSelectedEventUsecase>(
          () => GetSelectedEventUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<IGetSelectedStandUsecase>(
          () => GetSelectedStandUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<IDeleteSelectedEventUsecase>(
          () => DeleteSelectedEventUsecaseImpl(AppStand().injector.get()),
        );
    AppStand().injector.registerFactory<IDeleteSelectedStandUsecase>(
          () => DeleteSelectedStandUsecaseImpl(AppStand().injector.get()),
        );

    // Stores
    AppStand().injector.registerFactory<SelectConfigurationStore>(
          () => SelectConfigurationStore(
            getRelatedEventsAndStandsUsecase: AppStand().injector.get(),
            setSelectedEventUsecase: AppStand().injector.get(),
            setSelectedStandUsecase: AppStand().injector.get(),
          ),
        );
  }
}

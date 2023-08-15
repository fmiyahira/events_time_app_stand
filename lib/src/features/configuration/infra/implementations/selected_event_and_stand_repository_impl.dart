import 'package:events_time_app_stand/src/features/configuration/data/interfaces/local/selected_event_and_stand_datasource_local.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

class SelectedEventAndStandRepositoryImpl
    implements ISelectedEventAndStandRepository {
  final ISelectedEventAndStandDatasourceLocal datasourceLocal;

  SelectedEventAndStandRepositoryImpl(this.datasourceLocal);

  @override
  Future<void> setSelectedEvent(RelatedEventModel relatedEventModel) =>
      datasourceLocal.setSelectedEvent(relatedEventModel);

  @override
  Future<void> setSelectedStand(RelatedStandModel relatedStandModel) =>
      datasourceLocal.setSelectedStand(relatedStandModel);

  @override
  Future<RelatedEventModel?> getSelectedEvent() =>
      datasourceLocal.getSelectedEvent();

  @override
  Future<RelatedStandModel?> getSelectedStand() =>
      datasourceLocal.getSelectedStand();

  @override
  Future<void> deleteSelectedEvent() => datasourceLocal.deleteSelectedEvent();

  @override
  Future<void> deleteSelectedStand() => datasourceLocal.deleteSelectedStand();
}

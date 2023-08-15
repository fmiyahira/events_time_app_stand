import 'package:events_time_app_stand/src/features/configuration/data/interfaces/local/selected_event_and_stand_datasource_local.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class SelectedEventAndStandDatasourceLocalImpl
    implements ISelectedEventAndStandDatasourceLocal {
  final ILocalStorage localStorage;
  final String keyRelatedEventModel = 'relatedEventModel';
  final String keyRelatedStandModel = 'relatedStandModel';

  SelectedEventAndStandDatasourceLocalImpl(this.localStorage);

  @override
  Future<void> setSelectedEvent(RelatedEventModel relatedEventModel) async {
    await localStorage.setString(
      keyRelatedEventModel,
      relatedEventModel.toJson(),
    );
  }

  @override
  Future<void> setSelectedStand(RelatedStandModel relatedStandModel) async {
    await localStorage.setString(
      keyRelatedStandModel,
      relatedStandModel.toJson(),
    );
  }

  @override
  Future<RelatedEventModel?> getSelectedEvent() async {
    final String? stringReturned = await localStorage.getString(
      keyRelatedEventModel,
    );

    if (stringReturned == null) return null;

    return RelatedEventModel.fromJson(stringReturned);
  }

  @override
  Future<RelatedStandModel?> getSelectedStand() async {
    final String? stringReturned = await localStorage.getString(
      keyRelatedStandModel,
    );

    if (stringReturned == null) return null;

    return RelatedStandModel.fromJson(stringReturned);
  }

  @override
  Future<void> deleteSelectedEvent() async {
    await localStorage.delete(keyRelatedEventModel);
  }

  @override
  Future<void> deleteSelectedStand() async {
    await localStorage.delete(keyRelatedStandModel);
  }
}

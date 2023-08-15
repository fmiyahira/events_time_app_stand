import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

abstract class ISelectedEventAndStandRepository {
  Future<void> setSelectedEvent(RelatedEventModel relatedEventModel);
  Future<void> setSelectedStand(RelatedStandModel relatedStandModel);

  Future<RelatedEventModel?> getSelectedEvent();
  Future<RelatedStandModel?> getSelectedStand();

  Future<void> deleteSelectedEvent();
  Future<void> deleteSelectedStand();
}

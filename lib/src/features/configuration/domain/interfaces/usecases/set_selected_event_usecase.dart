import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';

abstract class ISetSelectedEventUsecase {
  Future<void> call(RelatedEventModel relatedEventModel);
}

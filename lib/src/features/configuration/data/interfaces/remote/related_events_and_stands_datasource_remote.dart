import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';

abstract class IRelatedEventsAndStandsDatasourceRemote {
  Future<RelatedEventsAndStandsModel> getRelatedEventsAndStands();
}

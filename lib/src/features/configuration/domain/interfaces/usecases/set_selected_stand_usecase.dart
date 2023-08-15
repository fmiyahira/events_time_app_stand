import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

abstract class ISetSelectedStandUsecase {
  Future<void> call(RelatedStandModel relatedStandModel);
}

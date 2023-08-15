import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/set_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

class SetSelectedStandUsecaseImpl implements ISetSelectedStandUsecase {
  final ISelectedEventAndStandRepository repository;

  SetSelectedStandUsecaseImpl(this.repository);

  @override
  Future<void> call(RelatedStandModel relatedStandModel) =>
      repository.setSelectedStand(relatedStandModel);
}

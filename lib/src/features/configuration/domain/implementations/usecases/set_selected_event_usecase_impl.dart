import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/set_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';

class SetSelectedEventUsecaseImpl implements ISetSelectedEventUsecase {
  final ISelectedEventAndStandRepository repository;

  SetSelectedEventUsecaseImpl(this.repository);

  @override
  Future<void> call(RelatedEventModel relatedEventModel) =>
      repository.setSelectedEvent(relatedEventModel);
}

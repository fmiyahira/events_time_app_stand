import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_event_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';

class GetSelectedEventUsecaseImpl implements IGetSelectedEventUsecase {
  final ISelectedEventAndStandRepository repository;

  GetSelectedEventUsecaseImpl(this.repository);

  @override
  Future<RelatedEventModel?> call() => repository.getSelectedEvent();
}

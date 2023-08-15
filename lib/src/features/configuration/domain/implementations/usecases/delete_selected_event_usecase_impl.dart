import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_event_usecase.dart';

class DeleteSelectedEventUsecaseImpl implements IDeleteSelectedEventUsecase {
  final ISelectedEventAndStandRepository repository;

  DeleteSelectedEventUsecaseImpl(this.repository);

  @override
  Future<void> call() => repository.deleteSelectedEvent();
}

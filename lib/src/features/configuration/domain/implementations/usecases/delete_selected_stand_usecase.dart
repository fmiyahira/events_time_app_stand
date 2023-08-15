import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/delete_selected_stand_usecase.dart';

class DeleteSelectedStandUsecaseImpl implements IDeleteSelectedStandUsecase {
  final ISelectedEventAndStandRepository repository;

  DeleteSelectedStandUsecaseImpl(this.repository);

  @override
  Future<void> call() => repository.deleteSelectedStand();
}

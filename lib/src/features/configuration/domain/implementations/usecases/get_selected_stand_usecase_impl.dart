import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/selected_event_and_stand_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_selected_stand_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

class GetSelectedStandUsecaseImpl implements IGetSelectedStandUsecase {
  final ISelectedEventAndStandRepository repository;

  GetSelectedStandUsecaseImpl(this.repository);

  @override
  Future<RelatedStandModel?> call() => repository.getSelectedStand();
}

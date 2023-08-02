import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/related_events_and_stands_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/usecases/get_related_events_and_stands_usecase.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';

class GetRelatedEventsAndStandsUsecaseImpl
    implements IGetRelatedEventsAndStandsUsecase {
  final IRelatedEventsAndStandsRepository repository;

  GetRelatedEventsAndStandsUsecaseImpl(this.repository);

  @override
  Future<RelatedEventsAndStandsModel> call() =>
      repository.getRelatedEventsAndStands();
}

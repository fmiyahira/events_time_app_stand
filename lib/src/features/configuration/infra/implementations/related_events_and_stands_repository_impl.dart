import 'package:events_time_app_stand/src/features/configuration/data/interfaces/remote/related_events_and_stands_datasource_remote.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/interfaces/repositories/related_events_and_stands_repository.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';

class RelatedEventsAndStandsRepositoryImpl
    implements IRelatedEventsAndStandsRepository {
  final IRelatedEventsAndStandsDatasourceRemote datasource;

  RelatedEventsAndStandsRepositoryImpl(this.datasource);

  @override
  Future<RelatedEventsAndStandsModel> getRelatedEventsAndStands() =>
      datasource.getRelatedEventsAndStands();
}

import 'package:events_time_app_stand/src/features/configuration/data/interfaces/remote/related_events_and_stands_datasource_remote.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class RelatedEventsAndStandsDatasourceRemoteImpl
    implements IRelatedEventsAndStandsDatasourceRemote {
  static const String ENDPOINT_RELATED_EVENTS_AND_STANDS_ID =
      '/api/mobile/events/';
  final IRequesting requesting;

  RelatedEventsAndStandsDatasourceRemoteImpl(this.requesting);

  @override
  Future<RelatedEventsAndStandsModel> getRelatedEventsAndStands() async {
    final RequestingResponse<dynamic> response = await requesting.get(
      ENDPOINT_RELATED_EVENTS_AND_STANDS_ID,
    );

    return RelatedEventsAndStandsModel.fromMap(response.body as List<dynamic>);
  }
}

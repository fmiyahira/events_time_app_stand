import 'package:events_time_app_stand/src/features/configuration/data/interfaces/remote/related_events_and_stands_datasource_remote.dart';
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_events_and_stands_model.dart';
import 'package:events_time_microapp_dependencies/events_time_microapp_dependencies.dart';

class RelatedEventsAndStandsDatasourceRemoteImpl
    implements IRelatedEventsAndStandsDatasourceRemote {
  static const String ENDPOINT_RELATED_EVENTS_AND_STANDS_ID =
      '/api/user/related_events_and_stands';
  final IRequesting requesting;

  RelatedEventsAndStandsDatasourceRemoteImpl(this.requesting);

  @override
  Future<RelatedEventsAndStandsModel> getRelatedEventsAndStands() async {
    // final RequestingResponse<dynamic> response = await requesting.get(
    //   ENDPOINT_RELATED_EVENTS_AND_STANDS_ID,
    // );

    // return RelatedEventsAndStandsModel.fromMap(<String, dynamic>{
    //   'events': response.body as List<Map<String, dynamic>>,
    // });

    return RelatedEventsAndStandsModel.fromMap(
      <Map<String, dynamic>>[
        <String, dynamic>{
          'id': 1,
          'name': 'Festival do Japão',
          'stands': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 1,
              'name': 'Bebidas',
              'is_cashier': false,
            },
          ],
        },
        <String, dynamic>{
          'id': 2,
          'name': 'Bon odori',
          'stands': <Map<String, dynamic>>[
            <String, dynamic>{
              'id': 3,
              'name': 'Caixa',
              'is_cashier': true,
            },
            <String, dynamic>{
              'id': 4,
              'name': 'Doces',
              'is_cashier': false,
            },
          ]
        },
      ],
    );
  }
}

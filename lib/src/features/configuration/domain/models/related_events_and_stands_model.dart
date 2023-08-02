// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:events_time_app_stand/src/features/configuration/domain/models/related_event_model.dart';

class RelatedEventsAndStandsModel {
  final List<RelatedEventModel> events;

  RelatedEventsAndStandsModel({
    required this.events,
  });

  factory RelatedEventsAndStandsModel.fromMap(List<Map<String, dynamic>> list) {
    return RelatedEventsAndStandsModel(
      events: List<RelatedEventModel>.from(
        list.map<RelatedEventModel>(
          (Map<String, dynamic> x) => RelatedEventModel.fromMap(x),
        ),
      ),
    );
  }
}

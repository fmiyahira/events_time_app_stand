// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:events_time_app_stand/src/features/configuration/domain/models/related_stand_model.dart';

class RelatedEventModel {
  final int id;
  final String name;
  final List<RelatedStandModel> stands;

  RelatedEventModel({
    required this.id,
    required this.name,
    required this.stands,
  });

  factory RelatedEventModel.fromMap(Map<String, dynamic> map) {
    return RelatedEventModel(
      id: map['id'] as int,
      name: map['name'] as String,
      stands: List<RelatedStandModel>.from(
        (map['stands'] as List<Map<String, dynamic>>).map<RelatedStandModel>(
          (Map<String, dynamic> x) => RelatedStandModel.fromMap(x),
        ),
      ),
    );
  }
}

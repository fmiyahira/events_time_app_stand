// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

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
        (map['stands'] as List<dynamic>).map<RelatedStandModel>(
          (dynamic x) => RelatedStandModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'stands': stands.map((RelatedStandModel x) => x.toMap()).toList(),
    };
  }

  String toJson() => json.encode(toMap());

  factory RelatedEventModel.fromJson(String source) =>
      RelatedEventModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

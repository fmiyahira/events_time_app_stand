import 'dart:convert';

// ignore_for_file: public_member_api_docs, sort_constructors_first

class RelatedStandModel {
  final int id;
  final String name;
  final bool isCashier;

  RelatedStandModel({
    required this.id,
    required this.name,
    required this.isCashier,
  });

  factory RelatedStandModel.fromMap(Map<String, dynamic> map) {
    return RelatedStandModel(
      id: map['id'] as int,
      name: map['name'] as String,
      isCashier: map['is_cashier'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'is_cashier': isCashier,
    };
  }

  String toJson() => json.encode(toMap());

  factory RelatedStandModel.fromJson(String source) =>
      RelatedStandModel.fromMap(json.decode(source) as Map<String, dynamic>);
}

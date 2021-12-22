// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'global_summary_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GlobalModel _$GlobalModelFromJson(Map<String, dynamic> json) {
  return GlobalModel(
    (json['Countries'] as List<dynamic>)
        .map((e) => Country.fromJson(e as Map<String, dynamic>))
        .toList(),
    Global.fromJson(json['Global'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$GlobalModelToJson(GlobalModel instance) =>
    <String, dynamic>{
      'Countries': instance.countries,
      'Global': instance.global,
    };

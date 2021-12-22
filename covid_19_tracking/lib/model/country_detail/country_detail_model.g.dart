// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryDetailsModel _$CountryDetailsModelFromJson(Map<String, dynamic> json) {
  return CountryDetailsModel(
    country: json['Country'] as String,
    confirmed: json['Confirmed'] as int,
    deaths: json['Deaths'] as int,
    recovered: json['Recovered'] as int,
    active: json['Active'] as int,
    dateTime: DateTime.parse(json['Date'] as String),
  );
}

Map<String, dynamic> _$CountryDetailsModelToJson(
        CountryDetailsModel instance) =>
    <String, dynamic>{
      'Country': instance.country,
      'Confirmed': instance.confirmed,
      'Deaths': instance.deaths,
      'Recovered': instance.recovered,
      'Active': instance.active,
      'Date': instance.dateTime.toIso8601String(),
    };

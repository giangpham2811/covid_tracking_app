// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Country _$CountryFromJson(Map<String, dynamic> json) {
  return Country(
    id: json['id'] as int?,
    country: json['Country'] as String,
    countryCode: json['CountryCode'] as String,
    slug: json['Slug'] as String,
    newConfirmed: json['NewConfirmed'] as int,
    newDeaths: json['NewDeaths'] as int,
    newRecovered: json['NewRecovered'] as int,
    totalConfirmed: json['TotalConfirmed'] as int,
    totalDeaths: json['TotalDeaths'] as int,
    totalRecovered: json['TotalRecovered'] as int,
    dateTime: json['Date'] == null ? null : DateTime.parse(json['Date'] as String),
  );
}

Map<String, dynamic> _$CountryToJson(Country instance) => <String, dynamic>{
      'id': instance.id,
      'Country': instance.country,
      'CountryCode': instance.countryCode,
      'Slug': instance.slug,
      'NewConfirmed': instance.newConfirmed,
      'TotalConfirmed': instance.totalConfirmed,
      'NewDeaths': instance.newDeaths,
      'TotalDeaths': instance.totalDeaths,
      'NewRecovered': instance.newRecovered,
      'TotalRecovered': instance.totalRecovered,
      'Date': instance.dateTime?.toIso8601String(),
    };

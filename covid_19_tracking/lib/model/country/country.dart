import 'package:json_annotation/json_annotation.dart';

part 'country.g.dart';

const String tableCountry = 'country';

class CountryField {
  static const List<String> values = [
    id,
    country,
    countryCode, slug, newConfirmed, totalConfirmed, newRecovered, totalRecovered, newDeaths, totalDeaths, dateTime];
  static const String id = 'id';
  static const String country = 'Country';
  static const String countryCode = 'CountryCode';
  static const String slug = 'Slug';
  static const String newConfirmed = 'NewConfirmed';
  static const String totalConfirmed = 'TotalConfirmed';
  static const String newDeaths = 'NewDeaths';
  static const String totalDeaths = 'TotalDeaths';
  static const String newRecovered = 'NewRecovered';
  static const String totalRecovered = 'TotalRecovered';
  static const String dateTime = 'Date';
}

@JsonSerializable()
class Country {
  Country({
    this.id,
    required this.country,
    required this.countryCode,
    required this.slug,
    required this.newConfirmed,
    required this.newDeaths,
    required this.newRecovered,
    required this.totalConfirmed,
    required this.totalDeaths,
    required this.totalRecovered,
    required this.dateTime,
  });

  factory Country.fromJson(Map<String, dynamic> json) => _$CountryFromJson(json);
  final int? id;
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'CountryCode')
  final String countryCode;
  @JsonKey(name: 'Slug')
  final String slug;
  @JsonKey(name: 'NewConfirmed')
  final int newConfirmed;
  @JsonKey(name: 'TotalConfirmed')
  final int totalConfirmed;
  @JsonKey(name: 'NewDeaths')
  final int newDeaths;
  @JsonKey(name: 'TotalDeaths')
  final int totalDeaths;
  @JsonKey(name: 'NewRecovered')
  final int newRecovered;
  @JsonKey(name: 'TotalRecovered')
  final int totalRecovered;
  @JsonKey(name: 'Date')
  final DateTime? dateTime;

  Map<String, dynamic> toJson() {
    return _$CountryToJson(this);
  }

  Country copy({
    int? id,
    String? country,
    String? countryCode,
    String? slug,
    int? newConfirmed,
    int? totalConfirmed,
    int? newDeaths,
    int? totalDeaths,
    int? newRecovered,
    int? totalRecovered,
    DateTime? dateTime,
  }) =>
      Country(
        id: id ?? this.id,
        country: country ?? this.country,
        countryCode: countryCode ?? this.countryCode,
        slug: slug ?? this.slug,
        newConfirmed: newConfirmed ?? this.newConfirmed,
        newDeaths: newDeaths ?? this.newDeaths,
        newRecovered: newRecovered ?? this.newRecovered,
        totalConfirmed: totalConfirmed ?? this.totalConfirmed,
        totalDeaths: totalDeaths ?? this.totalDeaths,
        totalRecovered: totalRecovered ?? this.totalRecovered,
        dateTime: dateTime ?? this.dateTime,
      );
}

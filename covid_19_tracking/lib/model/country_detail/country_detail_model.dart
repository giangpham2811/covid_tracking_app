import 'package:json_annotation/json_annotation.dart';

part 'country_detail_model.g.dart';

@JsonSerializable()
class CountryDetailsModel {
  CountryDetailsModel({required this.country, required this.confirmed, required this.deaths, required this.recovered, required this.active, required this.dateTime});

  factory CountryDetailsModel.fromJson(Map<String, dynamic> json) => _$CountryDetailsModelFromJson(json);
  @JsonKey(name: 'Country')
  final String country;
  @JsonKey(name: 'Confirmed')
  final int confirmed;
  @JsonKey(name: 'Deaths')
  final int deaths;
  @JsonKey(name: 'Recovered')
  final int recovered;
  @JsonKey(name: 'Active')
  final int active;
  @JsonKey(name: 'Date')
  final DateTime dateTime;

  Map<String, dynamic> toJson() => _$CountryDetailsModelToJson(this);
}

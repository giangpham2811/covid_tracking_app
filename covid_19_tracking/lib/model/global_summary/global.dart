import 'package:json_annotation/json_annotation.dart';

part 'global.g.dart';

@JsonSerializable()
class Global {
  Global(this.newConfirmed, this.totalConfirmed, this.newDeaths, this.totalDeaths, this.newRecovered, this.totalRecovered, this.date);

  factory Global.fromJson(Map<String, dynamic> json) => _$GlobalFromJson(json);
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
  final DateTime date;

  Map<String, dynamic> toJson() => _$GlobalToJson(this);
}

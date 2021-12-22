import 'package:json_annotation/json_annotation.dart';

import '../country/country.dart';
import 'global.dart';

part 'global_summary_model.g.dart';

@JsonSerializable()
class GlobalModel {
  GlobalModel(this.countries, this.global);

  factory GlobalModel.fromJson(Map<String, dynamic> json) => _$GlobalModelFromJson(json);
  @JsonKey(name: 'Countries')
  final List<Country> countries;
  @JsonKey(name: 'Global')
  final Global global;

  Map<String, dynamic> toJson() => _$GlobalModelToJson(this);
}

import 'dart:developer';

import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:covid_19_tracking/model/global_summary/global_summary_model.dart';
import 'package:covid_19_tracking/model/network/cases_service.dart';

class GlobalSummaryRepository {
  GlobalSummaryRepository({required this.restCaseService});

  final RestCaseService restCaseService;

  Future<GlobalModel> getGlobalSummary() async {
    return restCaseService
        .getGlobalSummary()
        .then(
          (GlobalModel value) => value,
        )
        .catchError((Object e) {
      log(e.toString());
      throw Exception('Error getting global summary data with error : ${e.toString()}');
    });
  }

  Future<List<Country>> getCountryList() async {
    return restCaseService
        .getGlobalSummary()
        .then(
          (GlobalModel value) => value.countries,
    )
        .catchError((Object e) {
      log(e.toString());
      throw Exception('Error getting global summary data with error : ${e.toString()}');
    });
  }

  Future<List<CountryDetailsModel>> getCountryDetail(String country) async {
    return restCaseService
        .getCountryDetail(country)
        .then((List<CountryDetailsModel> value,) =>
    value)
        .catchError((Object e) {
      log(e.toString());
      throw Exception('Error getting global summary data with error : ${e.toString()}');
    });
  }
}

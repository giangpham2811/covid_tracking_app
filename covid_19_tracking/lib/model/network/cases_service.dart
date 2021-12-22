import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:covid_19_tracking/model/global_summary/global_summary_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:retrofit/retrofit.dart';

part 'cases_service.g.dart';

@RestApi(baseUrl: 'https://api.covid19api.com')
abstract class RestCaseService {
  factory RestCaseService(Dio dio, {String baseUrl}) = _RestCaseService;

  @GET('/summary')
  Future<GlobalModel> getGlobalSummary();

  @GET('/country/{country}')
  Future<List<CountryDetailsModel>> getCountryDetail(@Path('country') String country);
}

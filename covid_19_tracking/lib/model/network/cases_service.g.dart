// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cases_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _RestCaseService implements RestCaseService {
  _RestCaseService(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.covid19api.com';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<GlobalModel> getGlobalSummary() async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<GlobalModel>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/summary',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = GlobalModel.fromJson(_result.data!);
    return value;
  }

  @override
  Future<List<CountryDetailsModel>> getCountryDetail(country) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<List<dynamic>>(
        _setStreamType<List<CountryDetailsModel>>(
            Options(method: 'GET', headers: <String, dynamic>{}, extra: _extra)
                .compose(_dio.options, '/country/$country',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = _result.data!
        .map((dynamic i) =>
            CountryDetailsModel.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}

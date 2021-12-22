import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:equatable/equatable.dart';

part 'country_details_event.dart';

part 'country_details_state.dart';

class CountryDetailsBloc extends Bloc<CountryDetailsEvent, CountryDetailsState> {
  CountryDetailsBloc(this.globalSummaryRepository, this.country) : super(CountryDetailsInitial());

  final GlobalSummaryRepository globalSummaryRepository;
  final String country;

  @override
  Stream<CountryDetailsState> mapEventToState(CountryDetailsEvent event) async* {
    if (event is CountryDetailsFetchedEvent) {
      try {
        final countryDetails = await globalSummaryRepository.getCountryDetail(country);
        yield CountryDetailsSuccess(countryDetailsModel: countryDetails);
      } catch (e) {
        yield CountryDetailsFailure(e);
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'country_list_event.dart';
part 'country_list_state.dart';

class CountryListBloc extends Bloc<CountryListEvent, CountryListState> {
  CountryListBloc(this.globalSummaryRepository) : super(CountryListInitial());

  final GlobalSummaryRepository globalSummaryRepository;
  @override
  Future<void> close() async {
    super.close();
  }

  @override
  Stream<CountryListState> mapEventToState(CountryListEvent event) async* {
    if (event is CountryListFetchedEvent) {
      try {
        if (state is CountryListInitial) {
          final _countries = await globalSummaryRepository.getCountryList();
          yield CountryListStateSuccess(countries: _countries);
        }
        if (state is CountryListStateSuccess) {
          final currentState = state as CountryListStateSuccess;
          yield CountryListStateSuccess(countries: currentState.countries);
        }
      } catch (exception) {
        yield CountryListStateFailure(exception);
      }
    }
  }
}

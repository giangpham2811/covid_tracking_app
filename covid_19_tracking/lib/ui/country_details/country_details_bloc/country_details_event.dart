part of 'country_details_bloc.dart';

abstract class CountryDetailsEvent extends Equatable {
  const CountryDetailsEvent();

  @override
  List<Object?> get props => [];
}

class CountryDetailsFetchedEvent extends CountryDetailsEvent {}

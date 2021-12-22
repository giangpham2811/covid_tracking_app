part of 'country_details_bloc.dart';

abstract class CountryDetailsState extends Equatable {
  @override
  // ignore: always_specify_types
  List<Object> get props => [];

  // ignore: sort_constructors_first
  const CountryDetailsState();
}

class CountryDetailsInitial extends CountryDetailsState {}

class CountryDetailsLoading extends CountryDetailsState {}

class CountryDetailsSuccess extends CountryDetailsState {
  final List<CountryDetailsModel> countryDetailsModel;

  // ignore: sort_constructors_first
  const CountryDetailsSuccess({required this.countryDetailsModel});

  @override
  // ignore: always_specify_types
  List<Object> get props => [countryDetailsModel];
}

class CountryDetailsFailure extends CountryDetailsState {
  final Object err;

  // ignore: sort_constructors_first
  const CountryDetailsFailure(this.err);

  @override
  String toString() {
    return err.toString();
  }
}

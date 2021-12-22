part of 'country_list_bloc.dart';

@immutable
abstract class CountryListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CountryListInitial extends CountryListState {}

class CountryListStateFailure extends CountryListState {
  CountryListStateFailure(this.err);

  final Object err;

  @override
  String toString() {
    return err.toString();
  }
}

class CountryListStateSuccess extends CountryListState {
  CountryListStateSuccess({required this.countries});

  final List<Country>? countries;

  @override
  List<Object> get props => [countries!];

  CountryListStateSuccess cloneWith({List<Country>? countries, required bool hasReachedEnd}) {
    return CountryListStateSuccess(countries: countries);
  }
}

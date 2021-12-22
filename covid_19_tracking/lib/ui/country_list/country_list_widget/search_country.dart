import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_widget/country_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:google_fonts/google_fonts.dart';

class SearchCountry extends SearchDelegate<Widget> {
  SearchCountry({required this.countryList});

  final List<Country> countryList;

  @override
  String get searchFieldLabel => 'Get your country';

  @override
  TextStyle get searchFieldStyle => const TextStyle(color: bgColor);

  @override
  ThemeData appBarTheme(BuildContext context) {
    final ThemeData theme = Theme.of(context).copyWith(
      textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme).apply(bodyColor: bgColor),
    );
    return theme;
  }

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          })
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestionList = query.isEmpty ? countryList : countryList.where((element) => element.country.toString().toLowerCase().contains(query)).toList();

    return Container(
      margin: const EdgeInsets.all(defaultPadding),
      color: bgColor,
      child: ListView.builder(
          itemCount: suggestionList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
                onTap: () {
                  Navigator.of(context).pushNamed('/countryDetails', arguments: suggestionList[index]);
                },
                child: CountryCard(country: suggestionList[index]));
          }),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }
}

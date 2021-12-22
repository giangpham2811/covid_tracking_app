import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_bloc/country_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_card.dart';

class CountryList extends StatefulWidget {
  const CountryList({Key? key, required this.countries}) : super(key: key);
  final List<Country> countries;

  @override
  _CountryListState createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  late CountryListBloc _countryListBloc;

  final _scrollController = ScrollController();
  final _scrollThreadhold = 250.0;

  @override
  void initState() {
    super.initState();
    _countryListBloc = BlocProvider.of<CountryListBloc>(context);
    _scrollController.addListener(() {
      final maxScrollExtent = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.position.pixels;
      if (maxScrollExtent - currentScroll <= _scrollThreadhold) {
        //scroll to the end of 1 page
        _countryListBloc.add(CountryListFetchedEvent());
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CountryListBloc, CountryListState>(
      builder: (BuildContext context, CountryListState state) {
        if (state is CountryListInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CountryListStateFailure) {
          return const Center(child: Text('Something went wrong', style: TextStyle(color: Colors.redAccent, fontSize: 16)));
        } else if (state is CountryListStateSuccess) {
          return ListView.builder(
            padding: const EdgeInsets.all(defaultPadding),
            itemCount: state.countries!.length, //add more item
            controller: _scrollController,
            itemBuilder: (BuildContext context, int index) {
              if (index >= state.countries!.length) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              return GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/countryDetails', arguments: widget.countries[index]);
                  },
                  child: CountryCard(country: widget.countries[index]));
            },
          );
        } else {
          return const Center(
            child: Text(
              'No internet connection ',
              style: TextStyle(fontSize: 30),
            ),
          );
        }
      },
    );
  }
}

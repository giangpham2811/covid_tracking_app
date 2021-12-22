import 'dart:async';

import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/model/global_summary/global_summary_model.dart';
import 'package:covid_19_tracking/model/network/cases_service.dart';
import 'package:covid_19_tracking/repositories/global_summary_repository.dart';
import 'package:covid_19_tracking/ui/country_list/country_list_bloc/country_list_bloc.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_bloc/summary_bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_list_widget/country_list.dart';
import 'country_list_widget/search_country.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _CountryScreenState createState() => _CountryScreenState();
}

class _CountryScreenState extends State<CountryScreen> {
  late Completer<void> _completer;
  late List<Country> _countries;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: bgColor),
            onPressed: () {
              showSearch(context: context, delegate: SearchCountry(countryList: _countries));
            },
          )
        ],
      ),
      body: BlocBuilder<SummaryBloc, SummaryState>(
        builder: (BuildContext context, SummaryState state) {
          if (state is SummaryStateLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SummaryStateSuccess) {
            _completer.complete();
            _completer = Completer();
            final GlobalModel globalSummaryModel = state.globalSummaryModel;
            _countries = globalSummaryModel.countries;
            _countries.sort((Country a, Country b) => a.country.compareTo(b.country));
            return RefreshIndicator(
              onRefresh: () {
                BlocProvider.of<SummaryBloc>(context).add(SummaryEventRefreshed(globalSummaryModel));
                return _completer.future;
              },
              child: BlocProvider(
                create: (BuildContext context) =>
                    CountryListBloc(GlobalSummaryRepository(restCaseService: RestCaseService(Dio(BaseOptions(receiveTimeout: 5000, connectTimeout: 5000)))))
                      ..add(CountryListFetchedEvent()),
                child: CountryList(countries: _countries),
              ),
            );
          } else if (state is SummaryStateFailure) {
            return const Center(child: Text('Fail to get data from api ', style: TextStyle(color: Colors.redAccent, fontSize: 25)));
          } else {
            return const Center(
              child: Text(
                'No internet connection ',
                style: TextStyle(fontSize: 30),
              ),
            );
          }
        },
      ),
    );
  }
}

import 'dart:async';

import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashboard_widget/global_card.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashbroad_bloc/summary_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'dashboard_widget/chart.dart';
import 'dashboard_widget/most_affected_panel.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  //scroll controller
  late Completer<void> _completer;
  late List<Country> _listCountry;

  @override
  void initState() {
    super.initState();
    _completer = Completer<void>();
  }

  @override
  void dispose() {
    BlocProvider.of<SummaryBloc>(context).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<SummaryBloc, SummaryState>(builder: (context, state) {
        if (state is SummaryStateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is SummaryStateSuccess) {
          _completer.complete();
          _completer = Completer();
          final globalSummaryModel = state.globalSummaryModel;
          _listCountry = globalSummaryModel.countries;
          return RefreshIndicator(
            onRefresh: () {
              BlocProvider.of<SummaryBloc>(context).add(SummaryEventRefreshed(globalSummaryModel));
              //return a "Completer object"
              return _completer.future;
            },
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                    child: Container(
                      margin: const EdgeInsets.only(left: defaultPadding * 2, right: defaultPadding * 2, top: defaultPadding * 2),
                      padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 500,
                      child: Chart(globalSummaryModel: globalSummaryModel),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(defaultPadding + 5),
                    child: Column(
                      children: [
                        globalCard('CONFIRMED', globalSummaryModel.global.totalConfirmed, globalSummaryModel.global.newConfirmed, confirmedColor),
                        globalCard('ACTIVE', globalSummaryModel.global.totalConfirmed - globalSummaryModel.global.totalDeaths - globalSummaryModel.global.totalRecovered,
                            globalSummaryModel.global.newConfirmed, activeColor),
                        globalCard('DEATH', globalSummaryModel.global.totalDeaths, globalSummaryModel.global.newDeaths, deathColor),
                        globalCard('RECOVERED', globalSummaryModel.global.totalRecovered, globalSummaryModel.global.newRecovered, recoveredColor),
                      ],
                    ),
                  ),
                  SizedBox(height: 370, child: MostAffectedPages(countries: _listCountry)),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          );
        } else if (state is SummaryStateFailure) {
          return const Center(child: Text('Something went wrong', style: TextStyle(color: Colors.redAccent, fontSize: 16)));
        } else {
          return const Center(
            child: Text(
              'No internet connection ',
              style: TextStyle(fontSize: 30),
            ),
          );
        }
      }),
    );
  }
}

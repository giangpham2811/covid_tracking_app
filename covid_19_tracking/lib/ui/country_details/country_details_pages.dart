import 'package:covid_19_tracking/database/country_database.dart';
import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashboard_widget/global_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'country_details_bloc/country_details_bloc.dart';
import 'country_details_widget/country_detail_card.dart';
import 'country_details_widget/country_details_line_chart.dart';

class CountryDetailPages extends StatefulWidget {
  const CountryDetailPages({Key? key, required this.title, required this.country}) : super(key: key);
  final String title;
  final Country country;

  @override
  _CountryDetailPagesState createState() => _CountryDetailPagesState();
}

class _CountryDetailPagesState extends State<CountryDetailPages> {
  List<Country> dbCountries = <Country>[];
  bool alreadyOnDatabase = false;

  @override
  void initState() {
    checkData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<CountryDetailsBloc>();

    return Scaffold(
      appBar: AppBar(
        actions: <Widget>[
          IconButton(
            icon: alreadyOnDatabase ? const Icon(Icons.favorite) : const Icon(Icons.favorite_border),
            onPressed: _onPress,
          )
        ],
        title: Text(widget.title),
      ),
      body: BlocBuilder<CountryDetailsBloc, CountryDetailsState>(builder: (context, state) {
        if (state is CountryDetailsInitial) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is CountryDetailsSuccess) {
          final summaryList = state.countryDetailsModel;
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                  margin: const EdgeInsets.all(defaultPadding),
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            ),
                            Center(
                              child: Container(
                                margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                                child: const Text(
                                  'OVERVIEW',
                                  style: TextStyle(color: textColorLight, fontWeight: FontWeight.bold, fontSize: 22),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: Divider(
                                thickness: 2,
                                color: Colors.white,
                              ),
                            )
                          ],
                        ),
                      ),
                      countryDetailCard(
                        'CONFIRMED',
                        summaryList[summaryList.length - 1].confirmed,
                        confirmedColor,
                        'ACTIVE',
                        summaryList[summaryList.length - 1].active,
                        activeColor,
                      ),
                      countryDetailCard(
                        'RECOVERED',
                        summaryList[summaryList.length - 1].recovered,
                        recoveredColor,
                        'DEATH',
                        summaryList[summaryList.length - 1].deaths,
                        deathColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 100,
                  child: Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      ),
                      Center(
                        child: Container(
                          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                          child: Text(
                            '${widget.title.toUpperCase()} STATISTIC CHART',
                            style: const TextStyle(color: textColorLight, fontWeight: FontWeight.bold, fontSize: 22),
                          ),
                        ),
                      ),
                      const Expanded(
                        child: Divider(
                          thickness: 2,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: cardColor),
                    height: 600,
                    width: 500,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 500,
                          child: DetailsBarChart(
                            countries: summaryList,
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: const <Widget>[
                              GlobalInformation(
                                color: confirmedColor,
                                title: 'Confirmed',
                              ),
                              GlobalInformation(
                                color: activeColor,
                                title: 'Active',
                              ),
                              GlobalInformation(
                                color: deathColor,
                                title: 'Deaths',
                              ),
                              GlobalInformation(
                                color: recoveredColor,
                                title: 'Recovered',
                              ),
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        } else if (state is CountryDetailsFailure) {
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

  Future<void> checkData() async {
    alreadyOnDatabase = await CountryDatabase.instance.isContain(widget.country.slug);
    print('TAG $alreadyOnDatabase');
    setState(() {});
  }

  Future<void> _onPress() async {
    if (alreadyOnDatabase) {
      await CountryDatabase.instance.deleteBySlug(widget.country.slug);
    } else {
      await CountryDatabase.instance.createData(widget.country);
    }
    checkData();
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

// Widget buildPageView(List<CountryDetailsModel> summaryList) {
//   return PageView(
//     controller: pageController,
//     onPageChanged: (index) {
//       setState(() {});
//     },
//     children: <Widget>[
//       DetailsBarChart(
//         countries: summaryList,
//       ),
//       DetailsBarChart(
//         countries: summaryList,
//       ),
//       DetailsBarChart(
//         countries: summaryList,
//       ),
//     ],
//   );
// }
}

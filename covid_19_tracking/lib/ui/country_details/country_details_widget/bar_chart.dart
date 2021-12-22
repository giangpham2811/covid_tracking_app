import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class CountryDetailsBarChart extends StatelessWidget {
  const CountryDetailsBarChart({Key? key, required this.countries, required this.color, required this.caseData, required this.title}) : super(key: key);
  final List<CountryDetailsModel> countries;
  final List<double> caseData;
  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(20.0),
            alignment: Alignment.center,
            child: Text(
              title,
              style: TextStyle(
                color: color,
                fontSize: 22.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(
            height: 350,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: caseData.reduce((value, element) => value > element ? value : element) * 1.1,
                barTouchData: BarTouchData(enabled: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: SideTitles(
                    getTextStyles: (value) => const TextStyle(
                      color: Colors.black,
                      fontSize: 12.0,
                      fontWeight: FontWeight.w500,
                    ),
                    margin: 10.0,
                    showTitles: true,
                    rotateAngle: 25.0,
                    getTitles: (double value) {
                      switch (value.toInt()) {
                        case 0:
                          return formatDate(countries.first.dateTime, [D]);
                        case 1:
                          return formatDate(countries.elementAt(countries.length - 6).dateTime, [D]);
                        case 2:
                          return formatDate(countries.elementAt(countries.length - 5).dateTime, [D]);
                        case 3:
                          return formatDate(countries.elementAt(countries.length - 4).dateTime, [D]);
                        case 4:
                          return formatDate(countries.elementAt(countries.length - 3).dateTime, [D]);
                        case 5:
                          return formatDate(countries.elementAt(countries.length - 2).dateTime, [D]);
                        case 6:
                          return formatDate(countries.last.dateTime, [D]);
                        default:
                          return '';
                      }
                    },
                  ),
                  leftTitles: SideTitles(
                      margin: 30,
                      showTitles: true,
                      getTextStyles: (value) => const TextStyle(
                            color: Colors.black,
                            fontSize: 14.0,
                            fontWeight: FontWeight.w500,
                          ),
                      getTitles: (value) {
                        if (value == 0) {
                          return '0';
                        } else if (value % 60== 0) {
                          if (value > 10000 && value < 100000) {
                            return '${value / 1000}k';
                          } else if (value > 100000) {
                            return '${value / 1000000}m';
                          } else {
                            if (value % 300 == 0 && value >= 1000) {
                              return '${value.toInt()}';
                            } else {
                              if (value % 20 == 0 && value <= 1000) {
                                return '${value.toInt()}';
                              }
                            }
                          }
                        }
                        return '';
                      }),
                ),
                gridData: FlGridData(
                  show: true,
                  checkToShowHorizontalLine: (value) => value % 3 == 0,
                  getDrawingHorizontalLine: (value) => FlLine(
                    color: Colors.black26,
                    strokeWidth: 1.0,
                    dashArray: [5],
                  ),
                ),
                borderData: FlBorderData(show: false),
                barGroups: caseData
                    .asMap()
                    .map((key, value) => MapEntry(
                          key,
                          BarChartGroupData(
                            x: key,
                            barRods: [
                              BarChartRodData(
                                y: value,
                                colors: [color],
                              ),
                            ],
                          ),
                        ))
                    .values
                    .toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

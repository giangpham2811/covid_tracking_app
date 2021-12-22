import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class DetailsCircleChart extends StatefulWidget {
  const DetailsCircleChart({Key? key, required this.country}) : super(key: key);
  final CountryDetailsModel country;

  @override
  State<StatefulWidget> createState() => DetailsCircleChartState();
}

class DetailsCircleChartState extends State<DetailsCircleChart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          SizedBox(
            height: 300,
            child: Stack(
              children: <Widget>[
                PieChart(
                  PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 100,
                      startDegreeOffset: -90,
                      pieTouchData: PieTouchData(touchCallback: (PieTouchResponse pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch && pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      sections: _showingSections(widget.country)),
                ),
                Positioned.fill(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const SizedBox(height: defaultPadding),
                      Text(
                        'Total Cases',
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: confirmedColor,
                              height: 0.5,
                            ),
                      ),
                      Text(
                        widget.country.confirmed.toString().replaceAllMapped(reg, mathFunc),
                        style: const TextStyle(color: textColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections(CountryDetailsModel country) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final fontSize = isTouched ? 25.0 : 12.0;
      final radius = isTouched ? 50.0 : 30.0;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: activeColor,
            value: country.active.toDouble(),
            title: '${(country.active / country.confirmed * 100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColorLight),
          );
        case 1:
          return PieChartSectionData(
            color: deathColor,
            value: country.deaths.toDouble(),
            title: ((country.deaths / country.confirmed * 100) > 5) ? '${(country.deaths / country.confirmed * 100000).toStringAsFixed(2)}%' : '__',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColorLight),
          );
        case 2:
          return PieChartSectionData(
            color: recoveredColor,
            value: country.recovered.toDouble(),
            title: ((country.recovered / country.confirmed * 100) > 5) ? '${(country.recovered / country.confirmed * 100).toStringAsFixed(2)}%' : '__',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: textColorLight),
          );

        default:
          throw Error();
      }
    });
  }
}

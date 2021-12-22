import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/model/global_summary/global_summary_model.dart';
import 'package:covid_19_tracking/ui/dashbroad/dashboard_widget/global_info.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class Chart extends StatefulWidget {
  const Chart({Key? key, required this.globalSummaryModel}) : super(key: key);
  final GlobalModel globalSummaryModel;

  @override
  State<StatefulWidget> createState() => ChartState();
}

class ChartState extends State<Chart> {
  int touchedIndex = -1;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(),
      child: Column(
        children: [
          Container(height: 20,),
          const Center(
            child: Text(
              'GLOBAL STATISTIC',
              style: TextStyle(color: bgColor, fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 20),
            height: 300,
            child: Stack(
              children: [
                PieChart(
                  PieChartData(
                      sectionsSpace: 0,
                      centerSpaceRadius: 100,
                      startDegreeOffset: -90,
                      pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
                        setState(() {
                          final desiredTouch = pieTouchResponse.touchInput is! PointerExitEvent && pieTouchResponse.touchInput is! PointerUpEvent;
                          if (desiredTouch && pieTouchResponse.touchedSection != null) {
                            touchedIndex = pieTouchResponse.touchedSection!.touchedSectionIndex;
                          } else {
                            touchedIndex = -1;
                          }
                        });
                      }),
                      sections: _showingSections(widget.globalSummaryModel)),
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
                        widget.globalSummaryModel.global.totalConfirmed.toString().replaceAllMapped(reg, mathFunc),
                        style: const TextStyle(color: textColor, fontSize: 20),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Text('Update at \n ${formatDate(widget.globalSummaryModel.global.date, [HH, ':', nn, ':', ss, '\n', dd, '-', mm, '-', yyyy])}'),
              ),
              Container(
                padding: const EdgeInsets.all(defaultPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const <Widget>[
                    GlobalInformation(
                      color: activeColor,
                      title: 'Total active',
                    ),
                    GlobalInformation(
                      color: deathColor,
                      title: 'Total deaths',
                    ),
                    GlobalInformation(
                      color: recoveredColor,
                      title: 'Total recovered',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> _showingSections(GlobalModel globalSummaryModel) {
    return List.generate(3, (i) {
      final isTouched = i == touchedIndex;
      final int active = globalSummaryModel.global.totalConfirmed - globalSummaryModel.global.totalDeaths - globalSummaryModel.global.totalRecovered;
      final fontSize = isTouched ? 20.0 : 12.0;
      final radius = isTouched ? 50.0 : 40.0;
      final color = isTouched? textColor : textColorLight;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: activeColor,
            value: active.toDouble(),
            title: '${(active / globalSummaryModel.global.totalConfirmed * 100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
          );
        case 1:
          return PieChartSectionData(
            color: deathColor,
            value: globalSummaryModel.global.totalDeaths.toDouble(),
            title: ((globalSummaryModel.global.totalDeaths / globalSummaryModel.global.totalConfirmed * 100) > 5)
                ? '${(globalSummaryModel.global.totalDeaths / globalSummaryModel.global.totalConfirmed * 100000).toStringAsFixed(2)}%'
                : '__',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
          );
        case 2:
          return PieChartSectionData(
            color: recoveredColor,
            value: globalSummaryModel.global.totalRecovered.toDouble(),
            title: '${(globalSummaryModel.global.totalRecovered / globalSummaryModel.global.totalConfirmed * 100).toStringAsFixed(2)}%',
            radius: radius,
            titleStyle: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: color),
          );
        default:
          throw Error();
      }
    });
  }
}

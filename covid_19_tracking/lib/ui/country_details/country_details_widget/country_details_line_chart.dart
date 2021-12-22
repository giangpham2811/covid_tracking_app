import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/model/country_detail/country_detail_model.dart';
import 'package:date_format/date_format.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class DetailsBarChart extends StatefulWidget {
  const DetailsBarChart({Key? key, required this.countries}) : super(key: key);
  final List<CountryDetailsModel> countries;

  @override
  _DetailsBarChartState createState() => _DetailsBarChartState();
}

class _DetailsBarChartState extends State<DetailsBarChart> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20, top: 10, bottom: 20),
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: _confirmed.isEmpty
          ? const Placeholder()
          : Center(
            child: LineChart(
                _mainData(),
              ),
          ),
    );
  }

  final int _divider = 25;
  final int _leftLabelsCount = 8;

  List<FlSpot> _confirmed = const [];
  List<FlSpot> _active = const [];
  List<FlSpot> _recovered = const [];
  List<FlSpot> _death = const [];

  double _minX = 0;
  double _maxX = 0;
  double _minY = 0;
  double _maxY = 0;
  double _leftTitlesInterval = 0;

  @override
  void initState() {
    super.initState();
    _prepareStockData();
  }

  void _prepareStockData() {
    final List<CountryDetailsModel> data = widget.countries;
    data.removeAt(410);
    double minY = 0;
    double maxY = 0;
    _confirmed = data.map((country) {
      if (minY > country.confirmed) {
        minY = country.confirmed.toDouble();
      }
      if (maxY < country.confirmed) {
        maxY = country.confirmed.toDouble();
      }
      return FlSpot(
        country.dateTime.millisecondsSinceEpoch.toDouble(),
        country.confirmed.toDouble(),
      );
    }).toList();
    _active = data.map((country) {
      // if (minY > country.active) {
      //   minY = country.active.toDouble();
      // }
      // if (maxY < country.active) {
      //   maxY = country.active.toDouble();
      // }
      return FlSpot(
        country.dateTime.millisecondsSinceEpoch.toDouble(),
        country.active.toDouble(),
      );
    }).toList();
    _recovered = data.map((country) {
      // if (minY > country.recovered) {
      //   minY = country.recovered.toDouble();
      // }
      // if (maxY < country.recovered) {
      //   maxY = country.recovered.toDouble();
      // }
      return FlSpot(
        country.dateTime.millisecondsSinceEpoch.toDouble(),
        country.recovered.toDouble(),
      );
    }).toList();
    _death = data.map((country) {
      // if (minY > country.confirmed) {
      //   minY = country.confirmed.toDouble();
      // }
      // if (maxY < country.confirmed) {
      //   maxY = country.confirmed.toDouble();
      // }
      return FlSpot(
        country.dateTime.millisecondsSinceEpoch.toDouble(),
        country.deaths.toDouble(),
      );
    }).toList();
    _minX = _confirmed.first.x;
    _maxX = _confirmed.last.x;
    _minY = (minY / _divider).floorToDouble() * _divider;
    _maxY = (maxY / _divider).ceilToDouble() * _divider;
    _leftTitlesInterval = (_maxY - _minY) / _leftLabelsCount;
    setState(() {});
  }

  LineChartData _mainData() {
    return LineChartData(
      gridData: _gridData(),
      titlesData: FlTitlesData(
        bottomTitles: _bottomTitles(),
        leftTitles: _leftTitles(),
      ),
      borderData: FlBorderData(
        border: const Border(
          left: BorderSide(color: Colors.black, width: 1),
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      minX: _minX,
      maxX: _maxX,
      minY: _minY,
      maxY: _maxY,
      lineBarsData: [
        _lineBarData(_confirmed, confirmedColor),
        _lineBarData(_active, activeColor),
        _lineBarData(_recovered, recoveredColor),
        _lineBarData(_death, deathColor),
      ],
    );
  }

  LineChartBarData _lineBarData(List<FlSpot> data, Color color) {
    return LineChartBarData(
      isCurved: true,
      curveSmoothness: 10,
      preventCurveOverShooting: true,
      preventCurveOvershootingThreshold: 5,
      spots: data,
      colors: [color],
      gradientFrom: const Offset(0.5, 0),
      gradientTo: const Offset(0.5, 1),
      barWidth: 2,
      dotData: FlDotData(
        show: false,
        getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(radius: 1, color: Colors.blue),
      ),
      // belowBarData: BarAreaData(
      //   show: true,
      //   colors: _gradientColors.map((color) => color.withOpacity(0.3)).toList(),
      //   gradientColorStops: const [0.25, 0.5, 0.75],
      //   gradientFrom: const Offset(0.5, 0),
      //   gradientTo: const Offset(0.5, 1),
      // ),
    );
  }

  SideTitles _leftTitles() {
    return SideTitles(
      showTitles: true,
      getTextStyles: (_) => const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      getTitles: (value) {
        if (value > 9999 && value < 1000000) {
          return '${(value / 1000).toStringAsFixed(0)}k';
        } else if (value > 999999) {
          return '${(value / 1000000).toStringAsFixed(0)}m';
        } else {
          return value.toInt().toString();
        }
      },
      margin: 20,
      interval: _leftTitlesInterval - 1,
    );
  }

  SideTitles _bottomTitles() {
    return SideTitles(
      showTitles: true,
      rotateAngle: 35,
      getTextStyles: (_) => const TextStyle(
        color: Colors.black,
        fontSize: 14,
      ),
      getTitles: (value) {
        final DateTime date = DateTime.fromMillisecondsSinceEpoch(value.toInt());
        return formatDate(date, ['M', ' ', 'yy']);
      },
      margin: 20,
      interval: (_maxX - _minX) / 6,
    );
  }

  FlGridData _gridData() {
    return FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        getDrawingHorizontalLine: (value) {
          return FlLine(
            color: Colors.black12,
            strokeWidth: 1,
          );
        },
        checkToShowHorizontalLine: (value) {
          return (value % (_leftLabelsCount - 1)) == 0;
        });
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView(List<CountryDetailsModel> summaryList) {
    return PageView(
      controller: pageController,
      onPageChanged: (index) {
        setState(() {});
      },
      children: <Widget>[
        DetailsBarChart(
          countries: summaryList,
        ),
        DetailsBarChart(
          countries: summaryList,
        ),
        DetailsBarChart(
          countries: summaryList,
        ),
      ],
    );
  }
}

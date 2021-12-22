import 'package:covid_19_tracking/di/constant.dart';
import 'package:flutter/material.dart';

Widget countryDetailCard(String leftTitle, int leftValue, Color leftColor, String rightTitle, int rightValue, Color rightColor) {
  return Card(
    elevation: 1,
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                leftTitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                'Total ',
                style: TextStyle(
                  color: leftColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                leftValue.toString().replaceAllMapped(reg, mathFunc),
                style: TextStyle(
                  color: leftColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Text(
                rightTitle,
                style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              Expanded(
                child: Container(),
              ),
              Text(
                'Total',
                style: TextStyle(
                  color: rightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
              Text(
                rightValue.toString().replaceAllMapped(reg, mathFunc),
                style: TextStyle(
                  color: rightColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

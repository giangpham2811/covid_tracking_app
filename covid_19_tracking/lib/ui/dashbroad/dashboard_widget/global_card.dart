import 'dart:ui';

import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:flutter/material.dart';

Widget globalCard(String title, int totalCount, int todayCount, Color color) {
  return Card(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
    elevation: 1,
    child: Container(
      height: 100,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: <Widget>[
          Text(
            title,
            style: const TextStyle(
              color: textColor,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
          Expanded(
            child: Container(),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    'Total',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    totalCount.toString().replaceAllMapped(reg, mathFunc),
                    style: TextStyle(
                      color: color,
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
                    'Today',
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                  Text(
                    todayCount.toString().replaceAllMapped(reg, mathFunc),
                    style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

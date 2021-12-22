import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CountryCard extends StatelessWidget {
  const CountryCard({
    Key? key,
    required this.country,
  }) : super(key: key);
  final Country country;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        height: 130,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              width: 190,
              margin: const EdgeInsets.all(defaultPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    country.country,
                    maxLines: 2,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: textColor),
                  ),
                  Container(
                    decoration: BoxDecoration(border: Border.all()),
                    child: Flag(
                      country.countryCode.toLowerCase(),
                      height: 40,
                      width: 60,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  'CONFIRMED: ${country.totalConfirmed.toString().replaceAllMapped(reg, mathFunc)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: confirmedColor),
                ),
                Text(
                  'ACTIVE: ${(country.totalConfirmed - country.totalDeaths - country.totalRecovered).toString().replaceAllMapped(reg, mathFunc)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: activeColor),
                ),
                Text(
                  'RECOVERED: ${(country.totalRecovered).toString().replaceAllMapped(reg, mathFunc)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: recoveredColor),
                ),
                Text(
                  'DEATHS: ${(country.totalDeaths).toString().replaceAllMapped(reg, mathFunc)}',
                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: deathColor),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}

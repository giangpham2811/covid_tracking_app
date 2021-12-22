import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/di/constant.dart';
import 'package:covid_19_tracking/model/country/country.dart';
import 'package:flag/flag.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class MostAffectedPages extends StatelessWidget {
  const MostAffectedPages({Key? key, required this.countries}) : super(key: key);
  final List<Country> countries;

  @override
  Widget build(BuildContext context) {
    countries.sort((b, a) => a.totalDeaths.compareTo(b.totalDeaths));
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: cardColor,
      ),
      margin: const EdgeInsets.symmetric(horizontal: defaultPadding * 2),
      child: Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.all(20),
              child: const Text(
                'MOST AFFECTED COUNTRIES',
                style: TextStyle(color: bgColor, fontWeight: FontWeight.bold, fontSize: 20),
              ),
            ),
          ),
          SizedBox(
            child: ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      Flag(
                        countries[index].countryCode,
                        height: 30,
                        width: 30,
                      ),
                      const SizedBox(width: 10),
                      SizedBox(
                          width: 185,
                          child: Text(
                            countries[index].country,
                            maxLines: 2,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          )),
                      Text(
                        'Deaths: ${countries[index].totalDeaths.toString().replaceAllMapped(reg, mathFunc)}',
                        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
                );
              },
              itemCount: 5,
            ),
          ),
        ],
      ),
    );
  }
}

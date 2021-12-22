import 'package:covid_19_tracking/di/color.dart';
import 'package:covid_19_tracking/ui/instruction/instruction_sources.dart';
import 'package:flutter/material.dart';

class InstructionScreen extends StatelessWidget {
  final String title;

  // ignore: sort_constructors_first
  const InstructionScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        color: cardColor,
        padding: const EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: InstructionSource.questionAnswers.length,
            itemBuilder: (BuildContext context, int index) {
              return ExpansionTile(
                collapsedTextColor: bgColor,
                textColor: Colors.red,
                iconColor:  Colors.red,
                collapsedIconColor: bgColor,
                title: Text(
                  InstructionSource.questionAnswers[index]['question'].toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      InstructionSource.questionAnswers[index]['answer'].toString(),
                      style: const TextStyle(fontWeight: FontWeight.bold, color: textColor),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}

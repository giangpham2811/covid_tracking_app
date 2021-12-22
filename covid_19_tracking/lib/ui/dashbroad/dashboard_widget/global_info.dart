import 'package:flutter/material.dart';

class GlobalInformation extends StatelessWidget {
  const GlobalInformation({
    Key? key,
    required this.color,
    required this.title,
  }) : super(key: key);
  final Color color;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          padding: const EdgeInsets.all(5),
          height: 15,
          width: 15,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color.withOpacity(.1),
          ),
          child: Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                color: color,
                width: 2,
              ),
            ),
          ),
        ),
        Text(title, style: TextStyle(fontSize: 14, color: color)),
      ],
    );
  }
}

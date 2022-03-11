// ignore_for_file: file_names, must_be_immutable

import 'package:flutter/material.dart';

class WeatherIonfoWidget extends StatelessWidget {
  String text;
  WeatherIonfoWidget({
    Key? key,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context).textTheme.caption!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'flutterfonts',
          letterSpacing: 1.2),
    );
  }
}

// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

class HeaderWidget extends StatelessWidget {
  String title;
  HeaderWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(
        title.toUpperCase(),
        style: Theme.of(context).textTheme.caption!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'flutterfonts',
            letterSpacing: 1.2),
      ),
    );
  }
}

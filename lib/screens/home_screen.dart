// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, must_be_immutable

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wd2/model/current_weather.dart';
import 'package:wd2/provider/provider.dart';
import '../../../widgets/main_card_widget/main_card_widget.dart';
import '../widgets/header_widget.dart';
import 'other_city.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

ThemeData _lightTheme =
    ThemeData(brightness: Brightness.light, primaryColor: Colors.white);

ThemeData _darkThem = ThemeData(brightness: Brightness.dark);
bool theme = true;

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Future<CurrentWetherData>? getCurrentWeather =
        Provider.of<LocationProvider>(context).getCurrentWeather;
    return MaterialApp(
      theme: theme ? _darkThem : _lightTheme,
      home: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 60),
              child: Align(
                alignment: Alignment.topRight,
                child: Switch(
                    activeColor: Colors.grey,
                    value: theme,
                    onChanged: (state) {
                      setState(() {
                        theme = state;
                      });
                    }),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50, bottom: 50),
                    child: MainCardWidget(
                      getCurrentWeather: getCurrentWeather,
                    ),
                  ),
                  HeaderWidget(
                    title: 'Forcast next 30 days',
                  ),
                  OtherCityWidget(),
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

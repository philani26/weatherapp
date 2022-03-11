// ignore_for_file: prefer_const_constructors, must_be_immutable

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:wd2/provider/provider.dart';
import 'package:wd2/screens/weather_details_screen.dart';
import '../../model/current_weather.dart';

class MainCardWidget extends StatefulWidget {
  late Future<CurrentWetherData>? getCurrentWeather;
  MainCardWidget({Key? key, required this.getCurrentWeather}) : super(key: key);

  @override
  State<MainCardWidget> createState() => _MainCardWidgetState();
}

class _MainCardWidgetState extends State<MainCardWidget> {
  late Future<CurrentWetherData>? getCurrentWeather;

  @override
  void initState() {
    super.initState();
    getCurrentWeather = widget.getCurrentWeather;
  }

  dynamic data;
  dynamic getCity = CurrentWetherData();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: FutureBuilder<CurrentWetherData>(
          future: Provider.of<LocationProvider>(context).getCurrentWeather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              data = snapshot.data!;
              var temp = snapshot.data!.main!;
              var weatherImage = snapshot.data!.weather![0].description!
                  .replaceAll(' ', '')
                  .toLowerCase();
              return GestureDetector(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WeatherDetailsScreen(data: data)));
                },
                child: Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                              child: Text(
                            data.name.toString(),
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                          )),
                          Center(
                            child: Text(
                              DateFormat()
                                  .add_MMMMEEEEd()
                                  .format(DateTime.now()),
                              style: Theme.of(context)
                                  .textTheme
                                  .caption!
                                  .copyWith(
                                      fontSize: 16,
                                      fontFamily: 'flutterfonts',
                                      letterSpacing: 1.2),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                padding: EdgeInsets.only(left: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${snapshot.data!.weather![0].description}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption!
                                          .copyWith(
                                              fontSize: 16,
                                              fontFamily: 'flutterfonts',
                                              letterSpacing: 1.2),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    TempWidget(
                                        text:
                                            '${snapshot.data!.main!.tempMax!.round().toString()}\u2103'),
                                    MaxAndMinTempWidget(
                                        temp:
                                            'max ${temp.tempMax!.round().toString()}\u2103 / min ${temp.tempMin!.round().toString()}\u2103'),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(right: 20),
                                child: Column(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width /
                                          4.5,
                                      height: 80,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(0),
                                          image: weatherImage.isNotEmpty
                                              ? DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/$weatherImage.png'),
                                                  fit: BoxFit.cover)
                                              : DecorationImage(
                                                  image: AssetImage(
                                                      'assets/images/icon.jpg'),
                                                  fit: BoxFit.cover)),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50),
                  child: Image.asset('assets/images/wind.gif'),
                ),
              );
            }
          }),
    );
  }
}

class MaxAndMinTempWidget extends StatelessWidget {
  String temp;
  Color? color;
  MaxAndMinTempWidget({Key? key, required this.temp, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      temp,
      style: Theme.of(context).textTheme.caption!.copyWith(
          fontSize: 16,
          fontWeight: FontWeight.bold,
          fontFamily: 'flutterfonts',
          letterSpacing: 1.2),
    );
  }
}

class TempWidget extends StatelessWidget {
  String text;
  TempWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(context)
          .textTheme
          .headline3!
          .copyWith(fontFamily: 'flutterfonts', letterSpacing: 1.2),
    );
  }
}

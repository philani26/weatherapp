import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wd2/model/current_weather.dart';
import 'package:wd2/widgets/header_widget.dart';
import 'package:wd2/widgets/main_card_widget/main_card_widget.dart';
import 'package:wd2/widgets/weather_Info_widget.dart';

class WeatherDetailsScreen extends StatefulWidget {
  final CurrentWetherData data;
  const WeatherDetailsScreen({Key? key, required this.data}) : super(key: key);

  @override
  State<WeatherDetailsScreen> createState() => _WeatherDetailsScreenState();
}

class _WeatherDetailsScreenState extends State<WeatherDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.arrow_back))),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                      child: HeaderWidget(title: widget.data.name.toString())),
                  Center(
                      child: Text(
                    DateFormat().add_MMMMEEEEd().format(DateTime.now()),
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        fontSize: 16,
                        fontFamily: 'flutterfonts',
                        letterSpacing: 1.2),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Center(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(0),
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/${widget.data.weather![0].description!.replaceAll(' ', '').toLowerCase()}.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                  ),
                  Center(
                      child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: WeatherIonfoWidget(
                      text: widget.data.weather![0].description.toString(),
                    ),
                  )),
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: SizedBox(
                      height: 150,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              TempWidget(
                                  text:
                                      '${widget.data.main!.tempMax!.round().toString()}\u2103'),
                              Column(
                                children: [
                                  MaxAndMinTempWidget(
                                      temp:
                                          'max ${widget.data.main!.tempMax!.round().toString()}\u2103'),
                                  MaxAndMinTempWidget(
                                      temp:
                                          'min ${widget.data.main!.tempMin!.round().toString()}\u2103'),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Column(
                              children: [
                                const Icon(
                                  Icons.air,
                                  size: 30,
                                ),
                                MaxAndMinTempWidget(temp: 'Wind'),
                                MaxAndMinTempWidget(
                                    temp:
                                        '${widget.data.wind!.deg.toString()}\u2103'),
                              ],
                            ),
                            Column(
                              children: [
                                const Icon(
                                  Icons.cloud,
                                  size: 30,
                                ),
                                MaxAndMinTempWidget(temp: 'Feel Like'),
                                MaxAndMinTempWidget(
                                    temp:
                                        '${widget.data.main!.feelsLike!.round()}\u2103'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )),
    );
  }
}

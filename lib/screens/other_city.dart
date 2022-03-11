// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wd2/model/week_report_weader_model.dart';
import 'package:wd2/provider/provider.dart';
import 'package:wd2/widgets/header_widget.dart';
import '../../../widgets/main_card_widget/main_card_widget.dart';
import '../../../widgets/weather_Info_widget.dart';

class OtherCityWidget extends StatefulWidget {
  const OtherCityWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<OtherCityWidget> createState() => _OtherCityWidgetState();
}

class _OtherCityWidgetState extends State<OtherCityWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 30),
      child: Container(
        padding: EdgeInsets.only(top: 10),
        child: Align(
          alignment: Alignment.topLeft,
          child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
            Padding(
              padding: const EdgeInsets.only(top: 30),
              child: SizedBox(
                height: 150,
                child: FutureBuilder<WeekWeatherReport>(
                    future:
                        Provider.of<LocationProvider>(context).getMonthFocast,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.separated(
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: ((context, index) {
                              var data = snapshot.data!.list![index];
                              var weatherImage =
                                  snapshot.data!.list![index].weather!;

                              for (var i = 0; i < weatherImage.length; i++) {
                                return GestureDetector(
                                  onTap: () {
                                    showDialogFun(
                                        context,
                                        snapshot.data!.list![index],
                                        snapshot.data);
                                  },
                                  child: SizedBox(
                                    width: 200,
                                    height: 10,
                                    child: Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            HeaderWidget(
                                                title: snapshot.data!.city.name
                                                    .toString()),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Container(
                                                  width: 50,
                                                  height: 50,
                                                  decoration: BoxDecoration(
                                                      image: DecorationImage(
                                                          image: AssetImage(
                                                              'assets/images/${weatherImage[i].description!.replaceAll(' ', '').toLowerCase()}.png'),
                                                          fit: BoxFit.cover))),
                                            ),
                                            WeatherIonfoWidget(
                                              text:
                                                  'Temp: ${data.main!.temp!.toStringAsFixed(0)}\u2103',
                                            ),
                                            WeatherIonfoWidget(
                                              text:
                                                  '${data.weather![0].description}',
                                            ),
                                          ],
                                        )),
                                  ),
                                );
                              }
                              return Center(child: Text('No data found..'));
                            }),
                            separatorBuilder: (context, index) =>
                                VerticalDivider(
                                  color: Colors.transparent,
                                  width: 5,
                                ),
                            itemCount: snapshot.data!.list!.length);
                      } else {
                        return Center(
                          child: Text('...'),
                        );
                      }
                    }),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Future showDialogFun(
      BuildContext context, ListElement listElement, WeekWeatherReport? data) {
    return showDialog(
        context: context,
        builder: (context) {
          var weatherImage = listElement.weather![0].description!
              .replaceAll(' ', '')
              .toLowerCase();
          return Center(
            child: Material(
                child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(10)),
              padding: EdgeInsets.all(15),
              width: MediaQuery.of(context).size.width * 0.7,
              height: 320,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HeaderWidget(title: data!.city.name.toString()),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: weatherImage.isEmpty
                          ? Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image:
                                          AssetImage('assets/images/icon.jpg'),
                                      fit: BoxFit.cover)))
                          : Container(
                              width: 50,
                              height: 50,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: AssetImage(
                                          'assets/images/$weatherImage.png'),
                                      fit: BoxFit.cover)))),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaxAndMinTempWidget(
                                temp:
                                    'max ${data.list![0].main!.tempMax!.round().toString()}\u2103'),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: MaxAndMinTempWidget(
                                temp: 'Wind ${data.list![0].wind!.deg}\u2103'),
                          ),
                          MaxAndMinTempWidget(
                              temp: ' Wind Speed ${data.list![0].wind!.speed}'),
                        ],
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.thermostat,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.air,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.air_outlined,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                ],
              ),
            )),
          );
        });
  }
}

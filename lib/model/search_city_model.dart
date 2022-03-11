// To parse this JSON data, do
//
//     final seachCityModel = seachCityModelFromJson(jsonString);

import 'dart:convert';

SeachCityModel seachCityModelFromJson(String str) =>
    SeachCityModel.fromJson(json.decode(str));

String seachCityModelToJson(SeachCityModel data) => json.encode(data.toJson());

class SeachCityModel {
  SeachCityModel({
    this.message,
    this.cod,
    this.count,
    this.list,
  });

  String? message;
  String? cod;
  int? count;
  List<ListElement>? list;

  factory SeachCityModel.fromJson(Map<String, dynamic> json) => SeachCityModel(
        message: json["message"],
        cod: json["cod"],
        count: json["count"],
        list: List<ListElement>.from(
            json["list"].map((x) => ListElement.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "cod": cod,
        "count": count,
        "list": List<dynamic>.from(list!.map((x) => x.toJson())),
      };
}

class ListElement {
  ListElement({
    this.id,
    this.name,
    this.coord,
    this.main,
    this.dt,
    this.wind,
    this.sys,
    this.rain,
    this.snow,
    this.clouds,
    this.weather,
  });

  int? id;
  String? name;
  Coord? coord;
  Main? main;
  int? dt;
  Wind? wind;
  Sys? sys;
  dynamic rain;
  dynamic snow;
  Clouds? clouds;
  List<Weather>? weather;

  factory ListElement.fromJson(Map<String, dynamic> json) => ListElement(
        id: json["id"],
        name: json["name"],
        coord: Coord.fromJson(json["coord"]),
        main: Main.fromJson(json["main"]),
        dt: json["dt"],
        wind: Wind.fromJson(json["wind"]),
        sys: Sys.fromJson(json["sys"]),
        rain: json["rain"],
        snow: json["snow"],
        clouds: Clouds.fromJson(json["clouds"]),
        weather:
            List<Weather>.from(json["weather"].map((x) => Weather.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "coord": coord!.toJson(),
        "main": main!.toJson(),
        "dt": dt,
        "wind": wind!.toJson(),
        "sys": sys!.toJson(),
        "rain": rain,
        "snow": snow,
        "clouds": clouds!.toJson(),
        "weather": List<dynamic>.from(weather!.map((x) => x.toJson())),
      };
}

class Clouds {
  Clouds({
    this.all,
  });

  int? all;

  factory Clouds.fromJson(Map<String, dynamic> json) => Clouds(
        all: json["all"],
      );

  Map<String, dynamic> toJson() => {
        "all": all,
      };
}

class Coord {
  Coord({
    required this.lat,
    required this.lon,
  });

  double lat;
  double lon;

  factory Coord.fromJson(Map<String, dynamic> json) => Coord(
        lat: json["lat"].toDouble(),
        lon: json["lon"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "lat": lat,
        "lon": lon,
      };
}

class Main {
  Main({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.humidity,
  });

  double? temp;
  double? feelsLike;
  int? tempMin;
  double? tempMax;
  int? pressure;
  int? humidity;

  factory Main.fromJson(Map<String, dynamic> json) => Main(
        temp: json["temp"].toDouble(),
        feelsLike: json["feels_like"].toDouble(),
        tempMin: json["temp_min"],
        tempMax: json["temp_max"].toDouble(),
        pressure: json["pressure"],
        humidity: json["humidity"],
      );

  Map<String, dynamic> toJson() => {
        "temp": temp,
        "feels_like": feelsLike,
        "temp_min": tempMin,
        "temp_max": tempMax,
        "pressure": pressure,
        "humidity": humidity,
      };
}

class Sys {
  Sys({
    required this.country,
  });

  String country;

  factory Sys.fromJson(Map<String, dynamic> json) => Sys(
        country: json["country"],
      );

  Map<String, dynamic> toJson() => {
        "country": country,
      };
}

class Weather {
  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });

  int? id;
  String? main;
  String? description;
  String? icon;

  factory Weather.fromJson(Map<String, dynamic> json) => Weather(
        id: json["id"],
        main: json["main"],
        description: json["description"],
        icon: json["icon"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "main": main,
        "description": description,
        "icon": icon,
      };
}

class Wind {
  Wind({
    this.speed,
    this.deg,
  });

  double? speed;
  int? deg;

  factory Wind.fromJson(Map<String, dynamic> json) => Wind(
        speed: json["speed"].toDouble(),
        deg: json["deg"],
      );

  Map<String, dynamic> toJson() => {
        "speed": speed,
        "deg": deg,
      };
}

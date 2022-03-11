import 'package:geocoding/geocoding.dart' as loc;
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:wd2/model/current_weather.dart';
import 'package:wd2/services/weather_service.dart';
import '../model/week_report_weader_model.dart';

class LocationProvider extends ChangeNotifier {
  double? _latitude;
  double? _longitude;
  String? _cityName;
  int count = 0;
  Future<CurrentWetherData>? _getCurrentWeather;
  Future<WeekWeatherReport>? _getMonthFocast;

  Future<CurrentWetherData>? get getCurrentWeather {
    return _getCurrentWeather;
  }

  Future<WeekWeatherReport>? get getMonthFocast {
    return _getMonthFocast;
  }

  double? get getLatitude {
    return _latitude;
  }

  double? get getLongitude {
    return _longitude;
  }

  String? get getCityName {
    return _cityName;
  }

  Future<void> locationService() async {
    Location location = Location();
    bool _serviceEnabled;
    PermissionStatus _permissionLocation;
    LocationData _locData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionLocation = await location.hasPermission();
    if (_permissionLocation == PermissionStatus.denied) {
      _permissionLocation = await location.requestPermission();
      if (_permissionLocation != PermissionStatus.granted) {
        return;
      }
    }
    _locData = await location.getLocation();

    _latitude = _locData.latitude!;
    _longitude = _locData.longitude!;

    List<loc.Placemark> placemark = await loc.placemarkFromCoordinates(
        _locData.latitude!, _locData.longitude!,
        localeIdentifier: 'en');

    if (count == 1) {
      _cityName = placemark[0].locality;
      _getCurrentWeather = WeatherService().getCurrentWeatherData(
          placemark[0].locality.toString(),
          double.parse(_locData.longitude.toString()),
          double.parse(_locData.latitude.toString()));

      _getMonthFocast = WeatherService()
          .getMonthForcastData(placemark[0].locality.toString());
    }
    count += 1;
    notifyListeners();
  }
}

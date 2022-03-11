import 'dart:convert';

import 'package:wd2/config/settings.dart';
import 'package:wd2/model/current_weather.dart';
import 'package:http/http.dart' as http;
import '../model/week_report_weader_model.dart';

class WeatherService {
  var header = {
    'content-type': 'application/json',
    'x-rapidapi-host': 'community-open-weather-map.p.rapidapi.com',
    'x-rapidapi-key': Settings.apikey
  };

  Future<CurrentWetherData> getCurrentWeatherData(
    String city,
    double lon,
    double lat,
  ) async {
    try {
      String url = '${Settings.baseUrl}/weather?q=$city&lon=$lon&lat=$lat';
      final response = await http.get(Uri.parse(url), headers: header);

      if (response.statusCode == 200) {
        final jsonRespond = jsonDecode(response.body);
        return CurrentWetherData.fromJson(jsonRespond);
      } else {
        throw Exception('Failed to load current weather');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<WeekWeatherReport> getMonthForcastData(String city) async {
    try {
      String url = '${Settings.baseUrl}/forecast?q=$city';
      final response = await http.get(Uri.parse(url), headers: header);
      if (response.statusCode == 200) {
        final jsonRespond = jsonDecode(response.body);
        return WeekWeatherReport.fromJson(jsonRespond);
      } else {
        throw Exception('Failed to load data');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}

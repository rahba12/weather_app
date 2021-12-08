// ignore_for_file: avoid_print

import 'dart:convert';
// import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_daily_model.dart';

// api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

class CurrentWeatherAPI {
  Future<DailyWeatherModel> getWeather(String city) async {
    const String baseUrl = 'api.openweathermap.org';
    const String path = 'data/2.5/weather';
    const String id = '45be234129c19397ccd98b18953cdf42';
    final queryParameters = {'q': city, 'appid': id, 'units': 'metric'};

    final uri = Uri.http(baseUrl, path, queryParameters);
    final response = await http.get(uri);
    print(response.body);

    if (response.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      var json = jsonDecode(response.body);
      print(DailyWeatherModel.fromJson(json));
      return DailyWeatherModel.fromJson(json);
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.

      throw Exception('Failed to load weather');
    }
  }
}

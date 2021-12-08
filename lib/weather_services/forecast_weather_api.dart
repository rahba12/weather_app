// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/models/hourly_weather_model.dart';

//http://api.weatherapi.com/v1/forecast.json?key=8f6c7f07a8a44f24b6b203118210612&q=cairo&days=1&hourly=24&aqi=no&alerts=no

class ForecastWeatherAPI {
  Future<ForecastWeatherModel> getWeather(String name) async {
    const String baseUrl = 'api.weatherapi.com';
    const String path = 'v1/forecast.jsonResult';
    const String id = '8f6c7f07a8a44f24b6b203118210612';
    final queryParameters = {'q': name, 'key': id, 'days': '1'};

    final uri = Uri.http(baseUrl, path, queryParameters);
    final response = await http.get(uri);
    print(response.body);
    if (response.statusCode == 200) {
      // If the server did return a 200 OK hourlyResponse,then parse the JSON.
      var jsonResult = jsonDecode(response.body);
      // var condition = jsonResult['condition'];
      // var image = condition['icon'].replaceAll('//', '');
      print(ForecastWeatherModel.fromJson(jsonResult));
      return ForecastWeatherModel.fromJson(jsonResult);
    } else {
      // If the server did not return a 200 OK hourlyResponse,then throw an exception.
      throw Exception('Failed to load weather');
    }
  }
}

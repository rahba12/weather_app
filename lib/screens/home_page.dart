// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/models/hourly_weather_model.dart';

// import 'package:weather_app/models/weather_daily_model.dart';
// import 'package:weather_app/weather_services/current_weather_api.dart';
import 'package:weather_app/weather_services/forecast_weather_api.dart';
import 'package:weather_app/widgets/widgets.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _chooseCityController = TextEditingController();

  // CurrentWeatherAPI weatherAPI = CurrentWeatherAPI();
  // DailyWeatherModel? _response;

  ForecastWeatherAPI forecastWeatherAPI = ForecastWeatherAPI();
  ForecastWeatherModel? _response;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              openDialog();
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            )),
        actions: [
          IconButton(
              onPressed: () => print('Menu'),
              icon: const Icon(
                Icons.menu,
                color: Colors.white,
              )),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/cloud.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.black38,
                    blurRadius: 6.0,
                    offset: Offset(0.0, 2.0))
              ],
            ),
          ),
          if (_response != null)
            ListView(
              padding: const EdgeInsets.fromLTRB(15.0, 80.0, 15.0, 15.0),
              children: [
                CurrentWeatherPrediction(
                  city: _response!.location!.name!,
                  temperature: _response!.current!.tempC!,
                  description: _response!.current!.condition!.text.toString(),
                  lowTemp: _response!.forecast!.forecastday![0].day!.mintempC!
                      .toDouble(),
                  highTemp: _response!.forecast!.forecastday![0].day!.maxtempC!
                      .toDouble(),
                  country: _response!.location!.country!,
                  feelsLike: _response!.current!.feelslikeC!,
                ),
                const SizedBox(
                  height: 50,
                ),
                Text(
                  'Today\'s Forecast',
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                HourlyForecast(
                  time: _response!.forecast!.forecastday![0].hour![12].time!
                      .toString(),
                  degree: _response!.forecast!.forecastday![0].hour![12].tempC!
                      .toInt(),
                  icon: _response!
                      .forecast!.forecastday![0].hour![12].condition!.icon,
                ),
                const SizedBox(
                  height: 15,
                ),
                Divider(
                  color: Colors.grey.shade50,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Additional Information',
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Card(
                  color: Colors.transparent,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shadowColor: Colors.black87,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        AdditionalPrediction(
                            label: 'Rain:',
                            value: _response!.forecast!.forecastday![0].day!
                                .dailyChanceOfRain!
                                .toDouble(),
                            measurement: '%'),
                        const SizedBox(
                          height: 5,
                        ),
                        AdditionalPrediction(
                            label: 'Wind:',
                            value: _response!.current!.windKph!.toDouble(),
                            measurement: 'Km/h'),
                        const SizedBox(
                          height: 5,
                        ),
                        AdditionalPrediction(
                            label: 'pressure:',
                            value: _response!.current!.pressureMb!.toDouble(),
                            measurement: 'hPa'),
                        const SizedBox(
                          height: 5,
                        ),
                        AdditionalPrediction(
                            label: 'Humidity:',
                            value: _response!.current!.humidity!.toDouble(),
                            measurement: '%'),
                        const SizedBox(
                          height: 5,
                        ),
                        AdditionalPrediction(
                            label: 'Cloud:',
                            value: _response!.current!.cloud!.toDouble(),
                            measurement: '%'),
                      ],
                    ),
                  ),
                ),
              ],
            )
          else
            Center(
                child: Text(
              'Search for your city',
              style: GoogleFonts.lato(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            )),
        ],
      ),
    );
  }

  Future openDialog() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: const Text(
              'Choose City',
            ),
            content: TextField(
              controller: _chooseCityController,
              decoration: const InputDecoration(
                hintText: 'City',
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    // _search();
                    _searchHourly();
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(fontSize: 18),
                  )),
            ],
          ));

  void _searchHourly() async {
    final response =
        await forecastWeatherAPI.getWeather(_chooseCityController.text);
    // var condition = forecastWeatherAPI
    //     .getWeather(_chooseCityController.text)
    //     .jsonResult['condition'];
    // var image = condition['icon'].replaceAll('//', '');
    print(response);
    setState(() {
      _response = response;
    });
  }
// void _search() async {
//   final response = await weatherAPI.getWeather(_chooseCityController.text);
//   print(response);
//   setState(() => _response = response);
// }

}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CurrentWeatherPrediction extends StatelessWidget {
  const CurrentWeatherPrediction(
      {Key? key,
      required this.temperature,
      required this.city,
      required this.description,
      required this.lowTemp,
      required this.highTemp,
      this.country,
      required this.feelsLike})
      : super(key: key);

  final double temperature;
  final double feelsLike;
  final double lowTemp;
  final double highTemp;
  final String city;
  final String? country;
  final String description;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('EEE, MMMM dd  ').add_jm().format(now);
    return Column(
      children: [
        RichText(
          text: TextSpan(
              text: city,
              style: GoogleFonts.lato(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white),
              children: [
                TextSpan(
                  text: ', ' + country!,
                  style: GoogleFonts.lato(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                      color: Colors.white),
                ),
              ]),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          formattedDate,
          style: GoogleFonts.lato(
              fontSize: 14, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          temperature.toInt().toString() + ' °',
          style: GoogleFonts.lato(
            color: Colors.white,
            fontSize: 35,
            fontWeight: FontWeight.w400,
          ),
        ),
        const SizedBox(
          height: 25,
        ),
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                highTemp.toInt().toString() + ' °',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                '   /   ',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              Text(
                lowTemp.toInt().toString() + ' °',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              const VerticalDivider(
                color: Colors.white,
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                'Feels Like',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                feelsLike.toInt().toString() + ' °',
                style: GoogleFonts.lato(
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    color: Colors.white),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Text(
          description,
          style: GoogleFonts.lato(
              fontSize: 20, fontWeight: FontWeight.w800, color: Colors.white),
        ),
      ],
    );
  }
}

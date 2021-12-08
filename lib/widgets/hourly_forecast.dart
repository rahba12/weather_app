import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:weather_app/weather_services/forecast_weather_api.dart';

class HourlyForecast extends StatelessWidget {
  const HourlyForecast(
      {Key? key, required this.time, required this.degree, this.icon})
      : super(key: key);

  final String time;
  final int degree;
  final String? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Card(
        color: Colors.transparent,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shadowColor: Colors.black87,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 2,
          ),
          itemBuilder: (BuildContext context, int index) => SizedBox(
            width: 60,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  time,
                  style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
                if (icon != null)
                  // Image.file(File())
                  // FileImage("icon"!)
                  Image.network(
                    icon!.replaceAll('//', ''),
                    width: 40,
                    height: 50,
                    fit: BoxFit.cover,
                  )
                else
                  Image.asset(
                    'images/clear.png',
                    width: 40,
                    height: 50,
                    fit: BoxFit.cover,
                  ),
                // Image(image: NetworkImage(icon!)),
                // Text(
                //   icon!,
                //   style: GoogleFonts.lato(
                //       fontSize: 14,
                //       fontWeight: FontWeight.w600,
                //       color: Colors.white),
                // ),
                //Image(image: NetworkImage(icon!)),
                Text(
                  degree.toString() + ' °',
                  style: GoogleFonts.lato(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ],
            ),
          ),
          itemCount: 10,
        ),
      ),
    );
  }
}

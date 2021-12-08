import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdditionalPrediction extends StatelessWidget {
  const AdditionalPrediction(
      {Key? key, this.label, this.value, this.measurement})
      : super(key: key);

  final String? label;
  final double? value;
  final String? measurement;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label!,
            style: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            value!.toInt().toString(),
            style: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
        const Spacer(),
        Expanded(
          child: Text(
            measurement!,
            style: GoogleFonts.lato(
                fontSize: 14, fontWeight: FontWeight.w600, color: Colors.white),
            textAlign: TextAlign.start,
          ),
        ),
      ],
    );
  }
}

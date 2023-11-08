import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AlertDialog buildNotification(
  String titleText,
  String contentText,
) {
  return AlertDialog(
    title: Center(
      child: Text(
        titleText,
        textAlign: TextAlign.center,
        style: GoogleFonts.originalSurfer(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFFFC6067),
            fontSize: 22,
          ),
        ),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 10),
      child: Text(
        contentText,
        style: GoogleFonts.sura(
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 19,
          ),
        ),
      ),
    ),
    contentPadding: EdgeInsets.zero,
  );
}

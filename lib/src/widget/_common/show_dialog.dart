import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

AlertDialog buildShowConfirm(
  String titleText,
  String contentText,
  String actionText,
  Function actionFunction,
  String cancelText,
  Function cancelFunction,
) {
  return AlertDialog(
    title: Center(
      child: Text(
        titleText,
        textAlign: TextAlign.center,
        style: GoogleFonts.originalSurfer(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF0072AD),
            fontSize: 22,
          ),
        ),
      ),
    ),
    content: Padding(
      padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
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
    actions: [
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFFC1C9CA),
          border: Border.all(
            color: const Color(0xFF0072AD),
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            actionFunction();
          },
          child: Text(
            actionText,
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
      SizedBox(width: 8),
      Container(
        height: 50,
        decoration: BoxDecoration(
          color: const Color(0xFF0072AD),
          border: Border.all(color: const Color.fromARGB(255, 245, 66, 72)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextButton(
          onPressed: () {
            cancelFunction();
          },
          child: Text(
            cancelText,
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                fontWeight: FontWeight.w400,
                color: Colors.black,
                fontSize: 20,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
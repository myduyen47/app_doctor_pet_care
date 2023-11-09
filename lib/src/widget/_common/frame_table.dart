import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrameTable extends StatelessWidget {
  final String text;
  const FrameTable({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        text,
        style: GoogleFonts.sura(
          textStyle: const TextStyle(
            color: Colors.black,
            fontSize: 19,
          ),
        ),
      ),
    );
  }
}
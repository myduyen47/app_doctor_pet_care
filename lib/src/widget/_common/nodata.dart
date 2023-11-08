import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class nodata extends StatelessWidget {
  const nodata({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 280),
      child: Center(
        child: Text(
          'Không có dữ liệu',
          style: GoogleFonts.sura(
            textStyle: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w400,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
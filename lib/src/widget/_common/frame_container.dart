import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ListContainer extends StatelessWidget {
  final String title;
  final IconData? icon;
  final VoidCallback? onTap;

  const ListContainer({
    required this.title,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFFFFE3D8),
              border: Border.all(
                color: Colors.grey.withOpacity(0.5),
              ),
            ),
            child: Column(
              children: [
                // Icon
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Icon(
                    icon,
                    color: const Color(0xFF0072AD),
                    size: 28,
                  ),
                ),
                // Text
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.sura(
                    textStyle: const TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

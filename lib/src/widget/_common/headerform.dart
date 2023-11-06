import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderScreen extends StatelessWidget {
  final String title;
  final String? avatarPath;
  final IconData? actionIcon1;
  final IconData? actionIcon2;
  final Function()? onAction1;
  final Function()? onAction2;
  final Color? backgroundColor;

  const HeaderScreen({
    super.key,
    required this.title,
    this.avatarPath,
    this.actionIcon1,
    this.actionIcon2,
    this.onAction1,
    this.onAction2,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(color: backgroundColor ?? const Color(0XFFFC6F73)),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 65,
                  height: 65,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CircleAvatar(
                          backgroundImage:
                              AssetImage(avatarPath ?? 'assets/logo1.png'),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  children: [
                    // Add an icon button
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFA2AA)),
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: const Icon(
                          Icons.search,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: onAction1,
                      ),
                    ),
                    const SizedBox(width: 10),
                    // Add an icon button
                    Container(
                      decoration: const BoxDecoration(
                          shape: BoxShape.circle, color: Color(0xFFFFA2AA)),
                      width: 45,
                      height: 45,
                      child: IconButton(
                        icon: const Icon(
                          Icons.message_rounded,
                          color: Colors.white,
                          size: 28,
                        ),
                        onPressed: onAction2,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: GoogleFonts.originalSurfer(
              textStyle: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormCancel extends StatelessWidget {
  final String services;
  final String date;
  final String time;
  final String petName;
  final String petAge;
  final String image;

  FormCancel({
    required this.services,
    required this.date,
    required this.time,
    required this.petName,
    required this.petAge,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF9FA4A8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      margin: const EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(
                    image,
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Thú cưng: $petName',
                      style: GoogleFonts.originalSurfer(
                          color: Colors.white,
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          )),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      petAge,
                      style: GoogleFonts.sura(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xFFFFE3D8),
                        fontSize: 18,
                      )),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFFFFE3D8),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            date,
                            style: GoogleFonts.sura(
                              color: const Color(0xFFFFE3D8),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          const Icon(
                            Icons.access_time_filled,
                            color: Color(0xFFFFE3D8),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            time,
                            style: GoogleFonts.sura(
                              color: const Color(0xFFFFE3D8),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.eco_outlined,
                        color: Color(0xFFFFE3D8),
                        size: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          services,
                          style: GoogleFonts.sura(
                              color: const Color(0xFFFFE3D8),
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

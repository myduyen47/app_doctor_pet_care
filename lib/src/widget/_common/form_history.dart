import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormHistory extends StatelessWidget {
  final String services;
  final String date;
  final String time;
  final String image;
  final Function() onPressed;

  FormHistory({
    required this.services,
    required this.date,
    required this.time,
    required this.image,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF71C5E9),
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
                Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.calendar_month_outlined,
                              color: Color(0xFF0072AD),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              date,
                              style: GoogleFonts.sura(
                                color: Colors.black,
                                textStyle: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 19,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time_filled,
                              color: Color(0xFF0072AD),
                              size: 30,
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            Text(
                              time,
                              style: GoogleFonts.sura(
                                color: Colors.black,
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
                  ],
                ),
                const Spacer(),
                Row(
                  children: [
                    CircleAvatar(
                      radius: 33,
                      backgroundImage: AssetImage(
                        image,
                      ),
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
                      const Icon(
                        Icons.eco_outlined,
                        color: Color(0xFF0072AD),
                        size: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          services,
                          style: GoogleFonts.sura(
                              color: Colors.black,
                              textStyle: const TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 19,
                              )),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFE3D8),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: TextButton(
                            onPressed: onPressed,
                            child: const Text(
                              'Đã hoàn thành',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      )
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

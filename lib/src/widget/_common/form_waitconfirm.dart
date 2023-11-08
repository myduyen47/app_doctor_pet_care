import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormWaitConfirm extends StatelessWidget {
  final String services;
  final String date;
  final String time;
  final String petName;
  final String petAge;
  final String image;
  final Function() onPressed;
  final Function() onPressedCancel;

  FormWaitConfirm({
    required this.services,
    required this.date,
    required this.time,
    required this.petName,
    required this.petAge,
    required this.image,
    required this.onPressed,
    required this.onPressedCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF0072AD),
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
                      Row(
                        children: [
                          const Icon(
                            Icons.calendar_month_outlined,
                            color: Color(0xFFFC666B),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            date,
                            style: GoogleFonts.sura(
                              color: const Color(0xFFFC666B),
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
                            color: Color(0xFFFC666B),
                            size: 30,
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Text(
                            time,
                            style: GoogleFonts.sura(
                              color: const Color(0xFFFC666B),
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
                        color: Color(0xFFFC666B),
                        size: 30,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          services,
                          style: GoogleFonts.sura(
                              color: const Color(0xFFFC666B),
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
                            borderRadius: BorderRadius.circular(10),
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
                            onPressed: onPressedCancel,
                            child: const Text(
                              'Hủy ',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: Container(
                          height: 45,
                          decoration: BoxDecoration(
                            color: const Color(0xFFFFFA2AA),
                            borderRadius: BorderRadius.circular(10),
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
                              'Xác nhận',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                              ),
                            ),
                          ),
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

import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:app_pet_care/src/widget/medical%20record/detail_medical_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFFFE3D8),
            body: SingleChildScrollView(
              child: Column(
                children: [
                  FrameBack(),
                  Text(
                    'Tất Cả Hồ Sơ',
                    style: GoogleFonts.originalSurfer(
                      textStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Stack(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 15, left: 20, right: 20, bottom: 15),
                        child: Container(
                          height: 140,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: const Color.fromARGB(255, 91, 171, 237)
                                    .withOpacity(0.5),
                                spreadRadius: 1,
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        left: 20,
                        top: 5,
                        child: Container(
                          alignment: Alignment.centerLeft,
                          height: 160,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: const Color(0xFF12609F),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'lib/assets/image/avt.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          left: 190,
                          top: 16,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Henry',
                                  style: GoogleFonts.sura(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 21,
                                    ),
                                  )),
                              Text('Tuổi: 2 tuổi',
                                  style: GoogleFonts.sura(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  )),
                              Text('Chủ nuôi: abc',
                                  style: GoogleFonts.sura(
                                    textStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                    ),
                                  )),
                              Padding(
                                padding: const EdgeInsets.only(left: 92),
                                child: Container(
                                  height: 40,
                                  width: 80,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF12609F),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: TextButton(
                                    onPressed: () {
                                      Get.to(DetailMedicalRecordScreen());
                                    },
                                    child: Text(
                                      'Chi tiết',
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          fontSize: 18,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ],
                  )
                ],
              ),
            )));
  }
}

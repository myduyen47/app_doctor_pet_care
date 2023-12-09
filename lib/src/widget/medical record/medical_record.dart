import 'package:app_pet_care/src/controller/getpetowner_list_controller.dart';
import 'package:app_pet_care/src/model/listpetowner_model.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:app_pet_care/src/widget/medical%20record/detail_medical_record.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class MedicalRecordScreen extends StatelessWidget {
  const MedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(GetPetOwnerListController());

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
                  FutureBuilder<List<ListPetOwnerModel>>(
                    future: controller.getPetOwnerList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final pet = snapshot.data![index];
                            return Stack(
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
                                          color: const Color.fromARGB(
                                                  255, 91, 171, 237)
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
                                    height: 155,
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
                                      child: Image.network(
                                        pet.pet!.avatar!.link!,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                    left: 180,
                                    top: 16,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(pet.pet!.name!,
                                            style: GoogleFonts.sura(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w600,
                                                fontSize: 21,
                                              ),
                                            )),
                                        Text(
                                            'Tuổi: ${calculateAge(pet.pet!.birthDate!)}',
                                            style: GoogleFonts.sura(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            )),
                                        Text('Chủ nuôi: ${pet.user!.fullName}',
                                            style: GoogleFonts.sura(
                                              textStyle: const TextStyle(
                                                color: Colors.black,
                                                fontWeight: FontWeight.w500,
                                                fontSize: 18,
                                              ),
                                            )),
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(left: 92),
                                          child: Container(
                                            height: 40,
                                            width: 80,
                                            decoration: BoxDecoration(
                                              color: const Color(0xFF12609F),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                            ),
                                            child: TextButton(
                                              onPressed: () {
                                               if (pet.pet!.id != null) {
    Get.to(
      const DetailMedicalRecordScreen(),
      arguments: {'pet': pet.pet, 'user': pet.user},
    )?.then((value) {
      if (value != null && value['isReload'] == true) {
        controller.onInit();
      }
    });
  } else {
    // Handle the case where pet.id is null
    // You can show a message or handle it according to your requirements
    print('Pet ID is null');
  }
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
                            );
                          },
                        );
                      } else if (snapshot.hasError) {
                        return Text('${snapshot.error}');
                      }
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    },
                  ),
                ],
              ),
            )));
  }

  String calculateAge(String birthDate) {
    final DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime now = DateTime.now();
    final DateTime birthday = formatter.parse(birthDate);

    int years = now.year - birthday.year;
    int months = now.month - birthday.month;
    int days = now.day - birthday.day;

    if (months < 0 || (months == 0 && days < 0)) {
      years -= 1;
      months += 12;
    }

    final String ageYears = years > 0 ? '$years tuổi ' : '';
    final String ageMonths = months > 0 ? '$months tháng' : '';

    if (years > 0 && months > 0) {
      return '$ageYears$ageMonths';
    } else if (years > 0) {
      return ageYears;
    } else {
      return ageMonths;
    }
  }
}

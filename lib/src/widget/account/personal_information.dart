import 'package:app_pet_care/src/controller/doctor_list_controller.dart';
import 'package:app_pet_care/src/model/doctor_model.dart';
import 'package:app_pet_care/src/widget/_common/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final doctorListController = Get.put(DoctorListController());

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Container(
          child: Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  height: 230,
                  color: const Color(0xFF5A71D4),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 22, bottom: 20, right: 16, left: 16),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          width: 45,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Get.back();
                            },
                            icon: const Icon(
                              Icons.arrow_back_ios_new_outlined,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        Container(
                          width: 45,
                          height: 38,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mode_edit_outline,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    FutureBuilder<List<DoctorModel>>(
                      future: doctorListController.InfoDoctorList(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (snapshot.hasError) {
                          return Text('Lỗi: ${snapshot.error}');
                        } else if (snapshot.hasData &&
                            snapshot.data!.isNotEmpty) {
                          final doctor = snapshot.data![0];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                doctor.fullName ?? 'N/A',
                                style: GoogleFonts.originalSurfer(
                                  textStyle: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 33,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 25),
                              Container(
                                width: 120,
                                height: 120,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      doctor.avatar?.link ?? '',
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Table(
                                children: <TableRow>[
                                  TableRow(
                                    children: [
                                      TableCell(
                                        child: detailForm(
                                          text: "Tuổi",
                                          content: calculateAge(
                                              doctor.birthDate ?? ''),
                                        ),
                                      ),
                                      TableCell(
                                        child: detailForm(
                                          text: "Giới tính",
                                          content: 'Nữ',
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Align(
                                alignment: Alignment.topLeft,
                                child: Column(
                                  children: [
                                    Text(
                                      'Thông tin bác sĩ',
                                      style: GoogleFonts.sura(
                                        textStyle: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                          fontSize: 23,
                                        ),
                                      ),
                                    ),
                                    Table(
                                      columnWidths: const {
                                        0: FlexColumnWidth(1),
                                        1: FlexColumnWidth(1.9),
                                      },
                                      children: [
                                        TableRow(children: [
                                          const TableInfo(
                                            text: 'Tên bác sĩ:',
                                          ),
                                          TableCell(
                                            child: Text(
                                              'Huỳnh Thị Mỹ Duyên',
                                              style: GoogleFonts.sura(
                                                textStyle: const TextStyle(
                                                  color: Colors.black,
                                                  fontSize: 21,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'Ngày sinh:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                DateFormat('dd-MM-yyyy').format(
                                                    DateTime.parse(
                                                        doctor.birthDate!)),
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'Giới tính:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                'Nữ',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'SĐT:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                doctor.phone ?? 'N/A',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'Email:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                doctor.email ?? 'N/A',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'Địa chỉ:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                doctor.address?.detail ?? 'N/A',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        TableRow(
                                          children: [
                                            const TableInfo(
                                              text: 'Major:',
                                            ),
                                            TableCell(
                                              child: Text(
                                                doctor.major ?? 'N/A',
                                                style: GoogleFonts.sura(
                                                  textStyle: const TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 22,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          );
                        } else {
                          return Text('Không có dữ liệu');
                        }
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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
    final String ageMonths = months > 0 ? '$months tháng ' : '';

    if (years > 0 && months > 0) {
      return '$ageYears';
    } else if (years > 0) {
      return ageYears;
    } else {
      return ageMonths;
    }
  }
}

class detailForm extends StatelessWidget {
  final String text;
  final String content;

  const detailForm({required this.text, required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("lib/assets/image/1.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            text,
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
          Text(
            content,
            style: GoogleFonts.sura(
              textStyle: const TextStyle(
                color: Colors.black,
                fontSize: 19,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class TableInfo extends StatelessWidget {
  final String text;

  const TableInfo({required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Text(
        text,
        style: GoogleFonts.sura(
          textStyle: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            fontSize: 22,
          ),
        ),
      ),
    );
  }
}

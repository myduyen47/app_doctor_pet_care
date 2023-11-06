import 'package:app_pet_care/src/widget/_common/custom_clipper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class PersonalInformationScreen extends StatelessWidget {
  const PersonalInformationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
                    Text(
                      'Huỳnh Thị Mỹ Duyên',
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
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: AssetImage('lib/assets/image/avt.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Table(
                      children: const <TableRow>[
                        TableRow(
                          children: [
                            TableCell(
                              child: detailForm(
                                text: "Tuổi",
                                content: '27 tuổi',
                              ),
                            ),
                            TableCell(
                              child: detailForm(
                                text: "Giới tính",
                                content: 'N/A',
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
                              1: FlexColumnWidth(1.3),
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
                                      '01/01/1994',
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
                                    text: 'Số điện thoại:',
                                  ),
                                  TableCell(
                                    child: Text(
                                      '0397058244',
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
                                      'N/A',
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
                                      'N/A',
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
                                    text: 'Chuyên ngành:',
                                  ),
                                  TableCell(
                                    child: Text(
                                      'Bác sĩ chuyên khoa nội tổng hợp',
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
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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

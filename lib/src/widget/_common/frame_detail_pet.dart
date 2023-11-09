import 'package:app_pet_care/src/widget/_common/frame_table.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FormDetailPet extends StatelessWidget {
  final String age;
  final String gender;
  final String birthday;
  final String weight;
  final String color;
  final String description;

  FormDetailPet({
    required this.age,
    required this.gender,
    required this.birthday,
    required this.weight,
    required this.color,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: const BorderSide(
          color: Colors.grey,
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'Chi tiết thú cưng',
                style: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
            Container(
              height: 1,
              color: Colors.black,
            ),
            const SizedBox(height: 10),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                TableRow(children: [
                  const FrameTable(text: 'Tuổi pet:'),
                  FrameTable(text: age),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Giới tính:'),
                  FrameTable(text: gender),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Sinh nhật:'),
                  FrameTable(text: birthday),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Cân nặng:'),
                  FrameTable(text: weight),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Màu lông:'),
                  FrameTable(text: color),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Mô tả:'),
                  FrameTable(text: description),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

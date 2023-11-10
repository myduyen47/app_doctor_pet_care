import 'package:app_pet_care/src/widget/_common/frame_table.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FrameDetailPeople extends StatelessWidget {
  final String name;
  final String email;
  final String phone;
  final String address;

  const FrameDetailPeople({
    required this.name,
    required this.email,
    required this.phone,
    required this.address,
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
                'Chi tiết chủ nuôi',
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
                1: FlexColumnWidth(2.2),
              },
              children: [
                TableRow(children: [
                  const FrameTable(text: 'Họ và tên:'),
                  FrameTable(text: name),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Email:'),
                  FrameTable(text: email),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'SĐT:'),
                  FrameTable(text: phone),
                ]),
                TableRow(children: [
                  const FrameTable(text: 'Địa chỉ:'),
                  FrameTable(text: address),
                ]),
              ],
            )
          ],
        ),
      ),
    );
  }
}

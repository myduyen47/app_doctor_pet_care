import 'package:app_pet_care/src/widget/_common/form_appointment_today.dart';
import 'package:app_pet_care/src/widget/_common/form_confirm.dart';
import 'package:app_pet_care/src/widget/_common/form_waitconfirm.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class ManageAppointmentHome extends StatelessWidget {
  const ManageAppointmentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFD1E2F0),
            body: DefaultTabController(
              length: 4,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    FrameBack(),
                    const SizedBox(
                      height: 15,
                    ),
                    TabBar(
                      tabs: const [
                        Tab(
                          text: 'Lịch hẹn hôm nay ',
                        ),
                        Tab(
                          text: 'Chờ xác nhận',
                        ),
                        Tab(
                          text: 'Đã xác nhận',
                        ),
                        Tab(
                          text: 'Đã hủy',
                        ),
                      ],
                      labelStyle: GoogleFonts.sura(
                          textStyle: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 21,
                      )),
                      labelColor: Colors.black,
                      unselectedLabelStyle: GoogleFonts.sura(
                        textStyle: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.grey,
                        ),
                      ),
                      indicatorColor: Colors.blue,
                      isScrollable: true,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: TabBarView(
                        children: [
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                TableCalendar(
                                  rowHeight: 40,
                                  headerStyle: const HeaderStyle(
                                      formatButtonVisible: false,
                                      titleCentered: true),
                                  availableGestures: AvailableGestures.all,
                                  firstDay: DateTime.utc(2010, 10, 16),
                                  lastDay: DateTime.utc(2030, 3, 14),
                                  focusedDay: DateTime.now(),
                                  currentDay: DateTime.now(),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                FormAppointmentToDay(
                                  services: 'Muốn dịch vụ gì cũng được',
                                  date: '20/09/2021',
                                  time: '15:00 PM',
                                  location:
                                      '123 Trần Hưng Đạo, phường Đông Xuyên, Tp Long Xuyên, tỉnh An Giang',
                                  onPressed: () {},
                                ),
                                FormAppointmentToDay(
                                  services: 'Muốn dịch vụ gì cũng được',
                                  date: '20/09/2021',
                                  time: '15:00 PM',
                                  location:
                                      '123 Trần Hưng Đạo, phường Đông Xuyên, Tp Long Xuyên, tỉnh An Giang',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                FormWaitConfirm(
                                  services: 'Tắm cho thú cưng',
                                  date: '20/09/2021',
                                  time: '15:00 PM',
                                  petName: 'Miu Miu',
                                  petAge: '2 tuổi',
                                  image: 'lib/assets/image/avt.jpg',
                                  onPressed: () {},
                                  onPressedCancel: () {},
                                ),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                FormConfirmed(
                                  services: 'Tắm cho thú cưng',
                                  date: '20/09/2021',
                                  time: '15:00 PM',
                                  petName: 'Miu Miu',
                                  petAge: '2 tuổi',
                                  image: 'lib/assets/image/avt.jpg',
                                  onPressed: () {},
                                ),
                                FormConfirmed(
                                  services: 'Tắm cho thú cưng',
                                  date: '20/09/2021',
                                  time: '15:00 PM',
                                  petName: 'Miu Miu',
                                  petAge: '2 tuổi',
                                  image: 'lib/assets/image/avt.jpg',
                                  onPressed: () {},
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
            )));
  }
}

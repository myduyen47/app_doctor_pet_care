import 'package:app_pet_care/src/controller/appointment_controller.dart';
import 'package:app_pet_care/src/controller/appointment_list_controller.dart';
import 'package:app_pet_care/src/widget/_common/complete_form.dart';
import 'package:app_pet_care/src/widget/_common/form_appointment_today.dart';
import 'package:app_pet_care/src/widget/_common/form_cancel.dart';
import 'package:app_pet_care/src/widget/_common/form_confirm.dart';
import 'package:app_pet_care/src/widget/_common/form_waitconfirm.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:app_pet_care/src/widget/_common/no_data.dart';
import 'package:app_pet_care/src/widget/_common/nodata.dart';
import 'package:app_pet_care/src/widget/_common/show_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

class ManageAppointmentHome extends StatelessWidget {
  const ManageAppointmentHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ControllerAppointment = Get.put(AppointmentController());
    final controller = Get.put(AppointmentListController());

    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xFFD1E2F0),
            body: DefaultTabController(
              length: 5,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const FrameBack(),
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
                          text: 'Lịch hẹn hoàn thành',
                        ),
                        Tab(
                          text: 'Đã hủy',
                        ),
                      ],
                      onTap: (tabIndex) {
                        _selectedStatus(
                            tabIndex, Get.put(AppointmentListController()));
                      },
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
                                Obx(
                                  () => Container(
                                    child: TableCalendar(
                                        rowHeight: 40,
                                        headerStyle: const HeaderStyle(
                                            formatButtonVisible: false,
                                            titleCentered: true),
                                        availableGestures:
                                            AvailableGestures.all,
                                        firstDay: DateTime.utc(2018, 10, 16),
                                        lastDay: DateTime.utc(2030, 3, 14),
                                        focusedDay: ControllerAppointment
                                            .selectedDate.value,
                                        currentDay: ControllerAppointment
                                            .selectedDate.value,
                                        onDaySelected:
                                            (selectedDate, focusedDate) => {
                                                  ControllerAppointment
                                                      .selectedDate
                                                      .value = selectedDate,
                                                  printInfo(
                                                      info:
                                                          'selectedDate: $selectedDate'),
                                                }),
                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  }

                                  var list = controller.list;
                                  if (list.isEmpty) {
                                    return const nodata();
                                  }

                                  // Lọc danh sách lịch hẹn dựa trên ngày đã chọn
                                  var filteredList = list.where((item) {
                                    DateTime sendDate = DateTime.parse(
                                            item.appointmentDate ?? '')
                                        .add(const Duration(hours: 7));
                                    return sendDate.year ==
                                            ControllerAppointment
                                                .selectedDate.value.year &&
                                        sendDate.month ==
                                            ControllerAppointment
                                                .selectedDate.value.month &&
                                        sendDate.day ==
                                            ControllerAppointment
                                                .selectedDate.value.day;
                                  }).toList();

                                  if (filteredList.isEmpty) {
                                    return const NoData();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: filteredList.length,
                                    itemBuilder: (context, index) {
                                      var item = filteredList[index];
                                      DateTime sendDate = DateTime.parse(
                                              item.appointmentDate ?? '')
                                          .add(const Duration(hours: 7));
                                      String dayOfWeek = sendDate.weekdayName;
                                      String date =
                                          '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                      String time =
                                          DateFormat('HH:mm').format(sendDate);

                                      return FormAppointmentToDay(
                                        services: item.service?.name ?? '',
                                        date: date,
                                        time: time,
                                        location:
                                            '123 Trần Hưng Đạo, phường Đông Xuyên, Tp Long Xuyên, tỉnh An Giang',
                                        onPressed: () {
                                          Get.dialog(
                                            buildShowConfirm(
                                              'Xác nhận lịch hẹn',
                                              'Bạn có chắc chắn muốn xác nhận lịch hẹn này không?',
                                              'Hoàn tác',
                                              () {
                                                Get.back();
                                              },
                                              'Xác nhận',
                                              () {
                                                controller.updateStatus(
                                                    status: '3', id: item.id);
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  var list = controller.list;
                                  if (list.isEmpty) {
                                    return const nodata();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      var item = list[index];
                                      DateTime sendDate = DateTime.parse(
                                              item.appointmentDate ?? '')
                                          .add(const Duration(hours: 7));
                                      String dayOfWeek = sendDate.weekdayName;
                                      String date =
                                          '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                      String time =
                                          DateFormat('HH:mm').format(sendDate);
                                      return FormWaitConfirm(
                                        services: item.service?.name ?? '',
                                        date: date,
                                        time: time,
                                        petName: item.pet?.name ?? '',
                                        petAge: calculateAge(
                                            item.pet?.birthDate ?? ''),
                                        image: 'lib/assets/image/PetPalace.png',
                                        onPressed: () {
                                          Get.dialog(
                                            buildShowConfirm(
                                              'Xác nhận lịch hẹn',
                                              'Bạn có chắc chắn muốn xác nhận lịch hẹn này không?',
                                              'Hoàn tác',
                                              () {
                                                Get.back();
                                              },
                                              'Xác nhận',
                                              () {
                                                controller.updateStatus(
                                                    status: '2', id: item.id);
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                        onPressedCancel: () {
                                          Get.dialog(buildShowConfirm(
                                            'Hủy lịch hẹn',
                                            'Bạn có chắc chắn muốn hủy lịch hẹn này không?',
                                            'Hoàn tác',
                                            () {
                                              Get.back();
                                            },
                                            'Xác nhận',
                                            () {
                                              controller.updateStatus(
                                                  status: '4', id: item.id);
                                              Get.back();
                                            },
                                          ));
                                        },
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  var list = controller.list;
                                  if (list.isEmpty) {
                                    return const nodata();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      var item = list[index];
                                      DateTime sendDate = DateTime.parse(
                                              item.appointmentDate ?? '')
                                          .add(const Duration(hours: 7));
                                      String dayOfWeek = sendDate.weekdayName;
                                      String date =
                                          '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                      String time =
                                          DateFormat('HH:mm').format(sendDate);
                                      return FormConfirmed(
                                        services: item.service?.name ?? '',
                                        date: date,
                                        time: time,
                                        petName: item.pet?.name ?? '',
                                        petAge: calculateAge(
                                            item.pet?.birthDate ?? ''),
                                        image: 'lib/assets/image/PetPalace.png',
                                        onPressed: () {
                                          Get.dialog(
                                            buildShowConfirm(
                                              'Hoàn Thành lịch hẹn',
                                              'Bạn đã thực hiện xong lịch hẹn này chưa?',
                                              'Hủy',
                                              () {
                                                Get.back();
                                              },
                                              'Hoàn thành',
                                              () {
                                                controller.updateStatus(
                                                    status: '3', id: item.id);
                                                Get.back();
                                              },
                                            ),
                                          );
                                        },
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  var list = controller.list;
                                  if (list.isEmpty) {
                                    return const nodata();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      var item = list[index];
                                      DateTime sendDate = DateTime.parse(
                                              item.appointmentDate ?? '')
                                          .add(const Duration(hours: 7));
                                      String dayOfWeek = sendDate.weekdayName;
                                      String date =
                                          '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                      String time =
                                          DateFormat('HH:mm').format(sendDate);
                                      return FormComplete(
                                        services: item.service?.name ?? '',
                                        date: date,
                                        time: time,
                                        petName: item.pet?.name ?? '',
                                        petAge: calculateAge(
                                            item.pet?.birthDate ?? ''),
                                        image: 'lib/assets/image/PetPalace.png',
                                      );
                                    },
                                  );
                                }),
                              ],
                            ),
                          ),
                          SingleChildScrollView(
                            child: Column(
                              children: [
                                Obx(() {
                                  if (controller.isLoading.value) {
                                    return const Center(
                                        child: CircularProgressIndicator());
                                  }
                                  var list = controller.list;
                                  if (list.isEmpty) {
                                    return const nodata();
                                  }
                                  return ListView.builder(
                                    shrinkWrap: true,
                                    physics:
                                        const NeverScrollableScrollPhysics(),
                                    itemCount: list.length,
                                    itemBuilder: (context, index) {
                                      var item = list[index];
                                      DateTime sendDate = DateTime.parse(
                                              item.appointmentDate ?? '')
                                          .add(const Duration(hours: 7));
                                      String dayOfWeek = sendDate.weekdayName;
                                      String date =
                                          '${dayOfWeek.toString()}, ${DateFormat('dd-MM-yyyy').format(sendDate)}';
                                      String time =
                                          DateFormat('HH:mm').format(sendDate);
                                      return FormCancel(
                                        services: item.service?.name ?? '',
                                        date: date,
                                        time: time,
                                        petName: item.pet?.name ?? '',
                                        petAge: calculateAge(
                                            item.pet?.birthDate ?? ''),
                                        image: 'lib/assets/image/PetPalace.png',
                                      );
                                    },
                                  );
                                }),
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

void _selectedStatus(int tabIndex, AppointmentListController controller) {
  String selectedStatus = '';
  if (tabIndex == 0) {
    selectedStatus = '2';
  } else {
    switch (tabIndex) {
      case 1:
        selectedStatus = '1';
        break;
      case 2:
        selectedStatus = '2';
        break;
      case 3:
        selectedStatus = '3';
        break;
      case 4:
        selectedStatus = '4';
        break;
      default:
        selectedStatus = '2';
        break;
    }
  }
  controller.selectedStatus = selectedStatus;
  controller.init();
}

extension DateTimeExtensions on DateTime {
  String get weekdayName {
    switch (weekday) {
      case 1:
        return 'Thứ hai';
      case 2:
        return 'Thứ ba';
      case 3:
        return 'Thứ tư';
      case 4:
        return 'Thứ năm';
      case 5:
        return 'Thứ sáu';
      case 6:
        return 'Thứ bảy';
      case 7:
        return 'Chủ nhật';
      default:
        return '';
    }
  }
}

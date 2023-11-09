import 'package:app_pet_care/src/widget/_common/frame_container.dart';
import 'package:app_pet_care/src/widget/_common/frame_image.dart';
import 'package:app_pet_care/src/widget/_common/headerform.dart';
import 'package:app_pet_care/src/widget/account/personal_information.dart';
import 'package:app_pet_care/src/widget/manage_appointment_schedules/manage_appointment_home.dart';
import 'package:app_pet_care/src/widget/medical%20record/medical_record.dart';
import 'package:app_pet_care/src/widget/statistical/statistical_home.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeDoctor extends StatelessWidget {
  static const double notifyHeight = 210;
  static const double overTopHeight = 15;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          HeaderScreen(
            title: 'BS.Huỳnh Thị Mỹ Duyên',
            avatarPath: 'lib/assets/image/avt.jpg',
            actionIcon1: Icons.search,
            actionIcon2: Icons.message_rounded,
            onAction1: () {},
            onAction2: () {},
            backgroundColor: const Color(0XFF0072AD),
          ),
          buildMain(),
          Expanded(
              child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 13),
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text('Không có lịch hẹn nào trong ngày hôm nay!!!',
                          maxLines: 2,
                          style: GoogleFonts.sura(
                            textStyle: const TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          )),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Tin tức',
                      style: GoogleFonts.sura(
                        textStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                    ),
                  ),
                ),
                CarouselSlider(
                  items: [
                    FrameImage(
                      image: 'lib/assets/image/tintuc5.jpg',
                    ),
                    FrameImage(
                      image: 'lib/assets/image/tintuc1.png',
                    ),
                    FrameImage(
                      image: 'lib/assets/image/tintuc2.jpg',
                    ),
                    FrameImage(
                      image: 'lib/assets/image/tintuc4.jpg',
                    ),
                    FrameImage(
                      image: 'lib/assets/image/tintuc3.png',
                    ),
                  ],
                  options: CarouselOptions(
                    height: 210.0,
                    enlargeCenterPage: true,
                    autoPlay: true,
                    aspectRatio: 16 / 9,
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enableInfiniteScroll: true,
                    autoPlayAnimationDuration:
                        const Duration(milliseconds: 300),
                    viewportFraction: 0.8,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: const Color(0XFF0072AD),
        animationDuration: const Duration(milliseconds: 300),
        color: const Color(0xFFFFE3D8),
        items: [
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.home,
              size: 32,
              color: Color(0XFF0072AD),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.edit_calendar_sharp,
              size: 32,
              color: Color(0XFF0072AD),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.groups_2_outlined,
              size: 32,
              color: Color(0XFF0072AD),
            ),
          ),
          GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.account_circle_outlined,
              size: 32,
              color: Color(0XFF0072AD),
            ),
          ),
        ],
        index: 0,
      ),
    ));
  }

  Widget buildMain() {
    return Expanded(
      child: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 50,
                    decoration: const BoxDecoration(
                      color: Color(0XFF0072AD),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    )),
                const SizedBox(height: notifyHeight - overTopHeight),
                Padding(
                  padding: const EdgeInsets.all(0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Lịch hẹn hôm nay',
                        style: GoogleFonts.sura(
                          textStyle: const TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          buildBanner(),
        ],
      ),
    );
  }

  Widget buildBanner() {
    return Positioned(
      top: overTopHeight,
      left: 0,
      right: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Container(
          height: notifyHeight,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 3,
                blurRadius: 7,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // First row
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  ListContainer(
                    title: 'Quản lý lịch khám',
                    icon: Icons.sticky_note_2_outlined,
                    onTap: () {
                      Get.to(ManageAppointmentHome());
                    },
                  ),
                  ListContainer(
                    title: 'Xác nhận lịch khám',
                    icon: Icons.calendar_month_outlined,
                    onTap: () {},
                  ),
                  ListContainer(
                    title: 'Thông tin cá nhân',
                    icon: Icons.person,
                    onTap: () {
                      Get.to(PersonalInformationScreen());
                    },
                  ),
                ],
              ),
              // Second row
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListContainer(
                    title: 'Thống kê danh số',
                    icon: Icons.stacked_bar_chart_outlined,
                    onTap: () {
                      Get.to(const StatisticalScreen());
                    },
                  ),
                  ListContainer(
                    title: 'Thông báo nhắc nhở',
                    icon: Icons.notifications_active_outlined,
                    onTap: () {},
                  ),
                  ListContainer(
                    title: 'Hồ sơ bệnh án',
                    icon: Icons.calendar_month_outlined,
                    onTap: () {
                      Get.to(const MedicalRecordScreen());
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

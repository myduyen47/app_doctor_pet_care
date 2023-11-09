import 'package:app_pet_care/src/widget/_common/form_history.dart';
import 'package:app_pet_care/src/widget/_common/frame_back.dart';
import 'package:app_pet_care/src/widget/_common/frame_detail_info.dart';
import 'package:app_pet_care/src/widget/_common/frame_detail_pet.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailMedicalRecordScreen extends StatelessWidget {
  const DetailMedicalRecordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: const Color(0xFFD1E2F0),
      body: DefaultTabController(
        length: 3,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const FrameBack(),
              Text(
                'Henry',
                style: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    color: Colors.black,
                    fontSize: 27,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                width: 70,
                height: 70,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: CircleAvatar(
                        backgroundImage: AssetImage('lib/assets/image/avt.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 15),
              Container(
                height: 5,
                color: const Color(0xFFFFE3D8),
              ),
              const SizedBox(height: 15),
              TabBar(
                tabs: const [
                  Tab(
                    child: Text('Thông tin cá nhân',
                        style: TextStyle(
                          color: Colors.black,
                        )),
                  ),
                  Tab(
                    child: Text(
                      'Lịch sử lịch hẹn',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      'Sổ sức khỏe',
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
                labelStyle: GoogleFonts.sura(
                    textStyle: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
                )),
                unselectedLabelStyle: GoogleFonts.sura(
                  textStyle: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                indicatorColor: Colors.blue,
                isScrollable: true,
              ),
              const SizedBox(height: 15),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.7,
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FrameDetailPeople(
                            name: 'Nguyễn Văn A',
                            email: 'abc@gmail.com',
                            phone: '0123456789',
                            address: '123, Đường ABC, Quận 1, TP.HCM',
                          ),
                          FormDetailPet(
                            age: '2 tuổi',
                            gender: 'giống cái',
                            birthday: '20/10/2019',
                            weight: '2kg',
                            color: 'trắng',
                            description: 'Henry là một chú chó rất hiền lành',
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          FormHistory(
                            services: 'Tắm',
                            onPressed: () {},
                            date: '10-10-2021',
                            time: '10:00',
                            image: 'lib/assets/image/PetPalace.png',
                            petName: 'Henry',
                            petAge: '2 tuổi',
                          ),
                        ],
                      ),
                    ),
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Card(
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
                                      'Tiêm ngừa nội kí sinh',
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
                                  Card(
                                    color: Colors.white,
                                    margin: const EdgeInsets.all(10),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(15),
                                      side: const BorderSide(
                                        color: Color(0xFF12609F),
                                        width: 1,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 10,
                                          bottom: 10,
                                          left: 15,
                                          right: 15),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Row(
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        children: [
                                                          const Icon(
                                                            Icons
                                                                .calendar_month_outlined,
                                                            color: Colors.black,
                                                            size: 28,
                                                          ),
                                                          const SizedBox(
                                                            width: 8,
                                                          ),
                                                          Text(
                                                            '11/11/2021',
                                                            style: GoogleFonts
                                                                .sura(
                                                              color:
                                                                  Colors.black,
                                                              textStyle:
                                                                  const TextStyle(
                                                                fontSize: 20,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        'Bệnh: Giun đũa',
                                                        style: GoogleFonts.sura(
                                                            textStyle:
                                                                const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                        )),
                                                      ),
                                                      Text(
                                                        'Thuốc: abc',
                                                        style: GoogleFonts.sura(
                                                            textStyle:
                                                                const TextStyle(
                                                          color: Colors.black,
                                                          fontSize: 18,
                                                        )),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              const Spacer(),
                                              const Row(
                                                children: [
                                                  CircleAvatar(
                                                    radius: 33,
                                                    backgroundImage: AssetImage(
                                                      'lib/assets/image/PetPalace.png',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
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
      ),
    ));
  }
}
